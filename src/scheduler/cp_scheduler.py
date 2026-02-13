import json
import collections
from xml.parsers.expat import model
import matplotlib.pyplot as plt
import matplotlib.colors as mcolors
from ortools.sat.python import cp_model
import pm4py
import pandas as pd
import plotly.express as px

# --- 1. Data Loading & Helper Functions ---

def load_data(assignments_data, dependencies_data_list, instance_log, top_n_instances=10):
    """
    Parses assignment rules and merges multiple dependency graphs.
    assignments_data: List of dicts defining task-resource-duration rules.
    dependencies_data_list: List of dicts (or loaded JSONs) containing dependency pairs.
    instance_log: Event log from PM4Py. Used to extract unique task instances if needed.
    top_n_instances: Number of top instances to consider from the event log.
    """
    
    # 1. Parse Assignments into a lookup dictionary
    # Format: {'ActivityA': [('R0', 2), ('R2', 1), ...]}
    task_options = collections.defaultdict(list)
    all_resources = set()
    
    for entry in assignments_data:
        task = entry['task']
        resource = entry['resource']
        duration = entry['duration']
        task_options[task].append((resource, duration))
        all_resources.add(resource)

    # 2. Flatten specific task instances from dependencies
    # We need to give every task in every process instance a unique ID.
    # Structure: tasks = { 'unique_id': {'base_name': 'ActivityA', 'preds': []} }
    
    tasks_to_schedule = {}
    
    for instance_idx, dep_data in enumerate(dependencies_data_list):
        tasks_to_schedule[instance_idx] = {}
        # We prefix task names with the instance index to handle multiple process instances
        # e.g., Instance 0, ActivityA -> "0_ActivityA"
        
        # Collect all tasks mentioned in dependencies
        # (Both predecessors and successors needs to be tracked)
        raw_dependencies = dep_data.get('dependencies', [])
        
        for pred, succ in raw_dependencies:
            unique_pred = pred
            unique_succ = succ
            
            # Initialize if new
            if unique_pred not in tasks_to_schedule[instance_idx]:
                tasks_to_schedule[instance_idx][unique_pred] = {'base_name': pred, 'preds': [], 'succs': []}
            if unique_succ not in tasks_to_schedule[instance_idx]:
                tasks_to_schedule[instance_idx][unique_succ] = {'base_name': succ, 'preds': [], 'succs': []}
            
            # Add dependency
            tasks_to_schedule[instance_idx][unique_succ]['preds'].append(unique_pred)
            tasks_to_schedule[instance_idx][unique_pred]['succs'].append(unique_succ)

    # Identify tasks for each instance from log
    # create mapping of {instance_idx: list of task_names}    
    # for each task in each trace in the log, add the value counts of the task name in the trace
    df = pm4py.convert_to_dataframe(instance_log)

    # reduce df to top_n instances (for testing)
    df = df[df['case:concept:name'].isin(df['case:concept:name'].unique()[:top_n_instances])]

    df['counter'] = df.groupby(['case:concept:name', 'concept:name']).cumcount()

    def append_suffix(row):
        if row['counter'] > 0:
            return f"{row['concept:name']}_{row['counter']}"
        return row['concept:name']

    df['concept:name'] = df.apply(append_suffix, axis=1)
    df = df.drop(columns=['counter'])

    instance_tasks = df[['case:concept:name', 'concept:name']].groupby('case:concept:name')['concept:name'].apply(list).to_dict()

    return task_options, sorted(list(all_resources)), tasks_to_schedule, instance_tasks

def get_base_name_from_instance(instance_name, known_base_tasks):
    """
    Extracts the base definition name from a specific instance name.
    e.g., 'ActivityI_1' -> 'ActivityI'
    """
    # 1. Exact match check
    if instance_name in known_base_tasks:
        return instance_name
    
    # 2. Underscore check (ActivityI_1 -> ActivityI)
    if '_' in instance_name:
        parts = instance_name.rsplit('_', 1) 
        if parts[0] in known_base_tasks:
            return parts[0]
            
    # 3. Fallback (if the base name isn't found exactly, return original)
    return instance_name

# --- 2. CP-SAT Solver Formulation ---

def solve_schedule(assignments_content, 
                   dependencies_contents, 
                   instance_log, 
                   top_n_instances=10, 
                   timeout=100, 
                   objective='makespan'
                   ):
    # Load and prep data
    task_rules, resources, tasks, instance_tasks = load_data(assignments_content, dependencies_contents, instance_log, top_n_instances)
    
    model = cp_model.CpModel()
    horizon = 500000000  # Arbitrary large number for the scheduling horizon
    instance_idx = 0 # Must be adapted once we handle multiple process models
    all_tasks = collections.defaultdict(dict)  
    # {'unique_id': 
    #   {'task_label': task_label, 
    #    'resource_options': 
    #      {
    #       'res_option1': (start_var, end_var, is_present), 
    #       'res_option2': ...
    #      }
    #   }
    # }
    
   # Create all task intervals for each instance
    for instance_id, task_list in instance_tasks.items():
        for task_name in task_list:
            unique_id = f"{instance_id}_{task_name}"
            base_name = get_base_name_from_instance(task_name, task_rules.keys())

            if task_name.endswith("_1"):
                print("Stop")
            if base_name not in task_rules:
                print(f"Warning: No assignment rules found for {base_name}. Skipping.")
                continue
            
            all_tasks[instance_id][task_name] = {}
            all_tasks[instance_id][task_name]['resource_options'] = {}
            options = task_rules[base_name]
            # Create interval variables for each option (resource-duration pair)
            for res, dur in options:
                start_var = model.NewIntVar(0, horizon, f'start_{unique_id}_{res}')
                end_var = model.NewIntVar(0, horizon, f'end_{unique_id}_{res}')
                is_present = model.NewBoolVar(f'is_present_{unique_id}_{res}')
                interval_var = model.NewOptionalIntervalVar(
                    start_var, dur, end_var, is_present, f'interval_{unique_id}_{res}'
                )

                # Store the interval_var along with the others
                all_tasks[instance_id][task_name]['resource_options'][res] = (
                    start_var, end_var, is_present, interval_var
                )

            # Exactly one resource option must be chosen
            model.Add(sum(opt[2] for opt in all_tasks[instance_id][task_name]['resource_options'].values()) == 1)

            
        for task_name in task_list:
            successors = tasks[instance_idx][f"{task_name}"]['succs']
            for succ in successors:
                # Add all precedence constraints for this task_name and its successors
                # Only adds precedence constraints for this instance's tasks, not across instances
                # The end date of task_name must be > the start date of succ
                current_task_options = all_tasks[instance_id][task_name]['resource_options'].values()
                if succ not in all_tasks[instance_id]:
                    # Successor {succ} not found in tasks for instance {instance_id}. Skipping precedence constraint.")
                    continue
                successor_task_options = all_tasks[instance_id][succ]['resource_options'].values()

                for current_task_opt in current_task_options:
                    for successor_task_opt in successor_task_options:
                        # If both options are present, then we add the precedence constraint
                        model.Add(successor_task_opt[0] >= current_task_opt[1]).OnlyEnforceIf(
                            [successor_task_opt[2], current_task_opt[2]]
                        )

    # Add no overlap constraints for tasks that share the same resource
    for res in resources:
        resource_intervals = []
        for instance_id, task_dict in all_tasks.items():
            for task_name, task_info in task_dict.items():
                if res in task_info['resource_options']:
                    # Pull the interval_var we stored (index 3)
                    _, _, _, interval_var = task_info['resource_options'][res]
                    resource_intervals.append(interval_var)
        
        if resource_intervals:
            # CP-SAT handles the "optional" part automatically
            model.AddNoOverlap(resource_intervals)

    if objective == 'makespan':
        # Objective: Minimize makespan (end of the latest finishing task)
        makespan = model.NewIntVar(0, horizon, 'makespan')
        all_end_vars = []
        for instance_id, task_dict in all_tasks.items():
            for task_name, task_info in task_dict.items():
                for res, (start_var, end_var, is_present, interval_var) in task_info['resource_options'].items():
                    all_end_vars.append(end_var)
        model.AddMaxEquality(makespan, all_end_vars)
        model.Minimize(makespan)
    elif objective == 'flow_time':
        # Objective: Minimize average flow time
        # Flow time = end time - start time for each task
        flow_times = []
        for instance_id, task_dict in all_tasks.items():
            for task_name, task_info in task_dict.items():
                for res, (start_var, end_var, is_present, interval_var) in task_info['resource_options'].items():
                    flow_time = model.NewIntVar(0, horizon, f'flow_time_{instance_id}_{task_name}_{res}')
                    model.Add(flow_time == end_var - start_var).OnlyEnforceIf(is_present)
                    model.Add(flow_time == 0).OnlyEnforceIf(is_present.Not())
                    flow_times.append(flow_time)

        avg_flow_time = model.NewIntVar(0, horizon, 'flow_time')
        model.AddDivisionEquality(avg_flow_time, sum(flow_times), len(flow_times))
        model.Minimize(avg_flow_time)
    else:
        raise NotImplementedError(f"Objective {objective} not implemented. Choose 'makespan' or 'flow_time'.")

    # Solve the model
    print(f'Solving the scheduling problem for objective {objective}...')
    solver = cp_model.CpSolver()
    solver.parameters.log_search_progress = True
    solver.parameters.max_time_in_seconds = timeout
    status = solver.Solve(model)
    if status in (cp_model.OPTIMAL, cp_model.FEASIBLE):
        print(f"Schedule found with {objective}: {solver.ObjectiveValue()}")
        return solver, all_tasks, task_rules, resources, tasks
    elif status == cp_model.INFEASIBLE:
        print("No feasible schedule found (infeasible).")
        return None
    else:
        print("Timeout.")
        return None   

def visualize_schedule(solver, all_tasks, task_rules, resources, tasks):
    """
    Bridges the CP-SAT variables to the Gantt Chart visualizer.
    """
    schedule_data = []
    instance_ids = []

    for instance_id, task_dict in all_tasks.items():
        instance_ids.append(instance_id)
        for task_name, task_info in task_dict.items():
            for res, (start_var, end_var, is_present, interval_var) in task_info['resource_options'].items():
                # Check if this specific resource option was chosen by the solver
                if solver.Value(is_present):
                    schedule_data.append({
                        'Instance_id': instance_id,
                        'Resource': res,
                        'Task': f"{instance_id}: {task_name}",
                        'Start': solver.Value(start_var),
                        'Finish': solver.Value(end_var)
                    })

    # Sort data so the Y-axis is organized by Resource name
    schedule_data.sort(key=lambda x: x['Resource'])
    
    # Now call the plotting logic
    fig, ax = plt.subplots(figsize=(15, 8))
    unique_tasks = list(set(a['Task'].split(": ")[1] for a in schedule_data))
    colors = list(mcolors.TABLEAU_COLORS.values())

    task_color_map = {task: colors[i % len(colors)] for i, task in enumerate(instance_ids)}

    for a in schedule_data:
        base_task_name = a['Task'].split(": ")[1]
        instance_id = a['Instance_id']
        ax.barh(a['Resource'], a['Finish'] - a['Start'], left=a['Start'], 
                color=task_color_map[instance_id], edgecolor='black')
        
    ax.set_xlabel('Time Units')
    ax.set_ylabel('Resources')
    ax.set_title(f'Optimal Schedule (Makespan: {solver.ObjectiveValue()})')
    plt.grid(axis='x', linestyle='--', alpha=0.6)
    plt.show()


def visualize_schedule_plotly(solver, all_tasks, task_rules, resources, tasks):
    """
    Visualizes the schedule using an interactive Plotly Gantt chart.
    """
    schedule_data = []

    for instance_id, task_dict in all_tasks.items():
        for task_name, task_info in task_dict.items():
            for res, (start_var, end_var, is_present, _) in task_info['resource_options'].items():
                if solver.Value(is_present):
                    start_val = solver.Value(start_var)
                    finish_val = solver.Value(end_var)
                    schedule_data.append({
                        'Instance_id': str(instance_id),
                        'Resource': res,
                        'Task': task_name,
                        'Start': start_val,
                        'Finish': finish_val,
                        'Duration': finish_val - start_val
                    })

    if not schedule_data:
        print("No data to visualize.")
        return

    # Create DataFrame
    df = pd.DataFrame(schedule_data)

    # Plotly timeline requires a 'Start' and 'Finish' but usually as dates.
    # We use px.timeline and then convert the X-axis back to linear integers.
    fig = px.timeline(
        df, 
        x_start="Start", 
        x_end="Finish", 
        y="Resource", 
        color="Instance_id",
        hover_data={
            'Instance_id': True,
            'Task': True,
            'Resource': True,
            'Start': True, 
            'Finish': True,
            'Duration': True
        },
        title=f"Interactive Schedule Visualization (Makespan: {int(solver.ObjectiveValue())})"
    )

    # MAGIC STEP: Force the X-axis to display as integers instead of dates
    fig.layout.xaxis.type = 'linear'
    
    # Map the data points to the linear scale
    for i, data in enumerate(fig.data):
        # Calculate the actual width based on our integer values
        # Plotly timeline internally converts dates to milliseconds
        data.x = df[df['Instance_id'] == data.name]['Duration'].tolist()
        data.base = df[df['Instance_id'] == data.name]['Start'].tolist()

    # UI Tweaks
    fig.update_yaxes(autorange="reversed") # Highest resource at the top
    fig.update_layout(
        xaxis_title="Time Units",
        yaxis_title="Resource / Machine",
        legend_title="Process Instances",
        hoverlabel=dict(bgcolor="white", font_size=12)
    )

    fig.show()


if __name__ == "__main__":
    ASSIGNMENTS_PATH = "output_files/assignments/a20g6_assignments.json"
    DEPENDENCIES_PATH = "output_files/dependencies/a20g6_dependencies.json"
    INSTANCES_PATH = "input_files/xes_files/log_single_loop.xes"
    
    with open(ASSIGNMENTS_PATH, "r") as f:
        assignments_json_raw = f.read()
    with open(DEPENDENCIES_PATH, "r") as f:
        dependencies_json_raw = f.read()
    instance_log = pm4py.read_xes(INSTANCES_PATH)
    assigns = json.loads(assignments_json_raw)
    deps = json.loads(dependencies_json_raw)
    
    # You can add multiple dependency dicts to this list to schedule multiple instances
    result = solve_schedule(assigns, [deps], instance_log, top_n_instances=10, timeout=300, objective='makespan')
    
    if result:
        solver, all_tasks, rules, resources, task_struct = result
        visualize_schedule_plotly(solver, all_tasks, rules, resources, task_struct)