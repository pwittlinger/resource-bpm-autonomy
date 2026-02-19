import json
import collections
from xml.parsers.expat import model
import matplotlib.pyplot as plt
import matplotlib.colors as mcolors
from ortools.sat.python import cp_model
import pm4py
import pandas as pd
import sys
from pathlib import Path

# Add parent directories to path
sys.path.insert(0, str(Path(__file__).parent.parent.parent))

from src.scheduler.resource_repository import ResourceRepository
from src.scheduler.schedule_instance import ScheduleInstance
from src.scheduler.plotly_visualizer import visualize_schedule_plotly

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

def solve_schedule(schedule_instances: list,
                   resource_repository: ResourceRepository,
                   top_n_instances=10, 
                   timeout=100, 
                   objective='makespan'
                   ):
    
    model = cp_model.CpModel()
    horizon = 500000000  # Arbitrary large number for the scheduling horizon
    release_time = 0
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

    # ensure instance_ids are unique across schedule_instances
    if len({instance.id for instance in schedule_instances}) != len(schedule_instances):
        raise ValueError("Duplicate instance_id found. Please ensure all ScheduleInstance objects have unique instance_id.")
    
   # Create all task intervals for each instance
    for instance in schedule_instances:
        for task_name in instance.get_task_list():
            all_tasks[instance.id][task_name] = {}
            
            unique_id = f"{instance.id}_{task_name}"
            resource = instance.get_resource_for_task(task_name)  # Get the resource for the task_name
            duration = resource_repository.get_duration_for_assignment(task_name, resource)

            # Create interval variables for task-resource-pair (resource-duration pair)
            start_var = model.NewIntVar(release_time, horizon, f'start_{unique_id}_{resource}')
            end_var = model.NewIntVar(0, horizon, f'end_{unique_id}_{resource}')
            interval_var = model.NewIntervalVar(
                start_var, duration, end_var, f'interval_{unique_id}_{resource}'
            )

            # Store the interval_var along with the others
            all_tasks[instance.id][task_name] = (
                start_var, end_var, interval_var, resource, release_time
            )
            
        for task_name in instance.get_task_list():
            successors = instance.get_successors(task_name)
            for succ in successors:
                # Add all precedence constraints for this task_name and its successors
                # Only adds precedence constraints for this instance's tasks, not across instances
                # The end date of task_name must be > the start date of succ
                
                if succ not in all_tasks[instance.id]:
                    # Successor {succ} not found in tasks for instance {instance_id}. Skipping precedence constraint.")
                    continue
                successor_task = all_tasks[instance.id][succ]

                sched_task =  all_tasks[instance.id][task_name]
                # Add precedence constraint between tasks. 
                model.Add(sched_task[1] <= successor_task[0])

    # Add no overlap constraints for tasks that share the same resource
    for res in resource_repository.get_all_resources():
        resource_intervals = []
        for sched_instance in schedule_instances:
            task_list = sched_instance.get_task_for_resource(res)
            
            instance_intervals = all_tasks[sched_instance.id]
            for task_name in instance_intervals:
                if task_name in task_list:
                    resource_intervals.append(instance_intervals[task_name][2])  # interval_var is at index 2
        if resource_intervals:
            # CP-SAT handles the "optional" part automatically
            model.AddNoOverlap(resource_intervals)

    if objective == 'makespan':
        # Objective: Minimize makespan (end of the latest finishing task)
        makespan = model.NewIntVar(0, horizon, 'makespan')
        all_end_vars = []
        for instance_id, task_dict in all_tasks.items():
            for task_name, task_info in task_dict.items():
                    all_end_vars.append(task_info[1])  # end_var is at index 1
        model.AddMaxEquality(makespan, all_end_vars)
        model.Minimize(makespan)
    
    elif objective == 'flow_time':
        # Objective: Minimize average flow time
        # Flow time = end time - start time for each task
        flow_times = []
        for instance_id, task_dict in all_tasks.items():
            start_vars = [vars[4] for vars in task_dict.values()]  # release_time is at index 4
            end_vars = [vars[1] for vars in task_dict.values()]    # end_var is at index 1
            
            start_min = model.NewIntVar(0, horizon, f'start_{instance_id}')
            model.add(start_min == min(start_vars))  # Earliest start time across all tasks in the instance
            end_max = model.NewIntVar(0, horizon, f'end_{instance_id}')
            model.add_max_equality(end_max, end_vars)
            
            flow_time = model.NewIntVar(0, horizon, f'flow_time_{instance_id}_{task_name}')
            model.Add(flow_time == end_max - start_min)  # end_var - start_var
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

        for flow_time in flow_times:
            print(f"Flow time for instance: {solver.Value(flow_time)}")
        return solver, all_tasks
    elif status == cp_model.INFEASIBLE:
        print("No feasible schedule found (infeasible).")
        return None
    else:
        print("Timeout.")
        return None   


if __name__ == "__main__":
    ASSIGNMENTS_PATH = "input_files/assignments/a20g6_assignments.json"
    INSTANCES_PATH = "input_files/xes_files/log_with_resources.xes"
    PETRI_PATH = "input_files/petri_net/a20g6.pnml"


    # create a schedule_instance object
    sched_instances = []
    for i in range(10):
        sched_instance = ScheduleInstance(xes_path=INSTANCES_PATH, 
                                        petri_net_pnml_path=PETRI_PATH, 
                                        output_path="output_files/schedule_instance_output")
        sched_instances.append(sched_instance)

    resource_repository = ResourceRepository(ASSIGNMENTS_PATH)
    # You can add multiple dependency dicts to this list to schedule multiple instances
    result = solve_schedule(schedule_instances=sched_instances, 
                            resource_repository=resource_repository, 
                            timeout=300, 
                            objective='flow_time')
    
    if result:
        solver, all_tasks = result
        visualize_schedule_plotly(solver, all_tasks)