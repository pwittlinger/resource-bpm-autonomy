import json
import collections
from xml.parsers.expat import model
import matplotlib.pyplot as plt
import matplotlib.colors as mcolors
from ortools.sat.python import cp_model
import pm4py
from pathlib import Path
import os
import pandas as pd
import plotly.express as px
import sys

# Add parent directories to path
sys.path.insert(0, str(Path(__file__).parent.parent.parent))

from src.scheduler.resource_repository import ResourceRepository
from src.scheduler.schedule_instance import ScheduleInstance
from src.scheduler.plotly_visualizer import visualize_schedule_plotly
from src.scheduler.slack_analysis import export_highest_slack_instance

def solve_schedule(schedule_instances: list[ScheduleInstance], 
                   resource_repository: ResourceRepository, 
                   top_n_instances=10, 
                   timeout=100, 
                   objective='makespan'
                   ):
    
    model = cp_model.CpModel()
    # Horizon: sum of the maximum duration per task across all instances.
    # This is a tight safe upper bound (all tasks run sequentially on their slowest resource).
    horizon = 0
    for instance in schedule_instances:
        for task_name in instance.get_task_list():
            resources = resource_repository.get_resources_for_task(task_name)
            if resources:
                horizon += max(
                    resource_repository.get_duration_for_assignment(task_name, res)
                    for res in resources
                )

    release_time = 0
    all_tasks = collections.defaultdict(dict)  
    all_resources = set()
    
    # Create all task intervals for each instance
    for instance in schedule_instances:
        for task_name in instance.get_task_list():
            all_tasks[instance.id][task_name] = {}
            unique_id = f"{instance.id}_{task_name}"
            
            for resource in resource_repository.get_resources_for_task(task_name):
                all_resources.add(resource)
                duration = resource_repository.get_duration_for_assignment(task_name, resource)

                # Create interval variables for task-resource-pair (resource-duration pair)
                start_var = model.NewIntVar(release_time, horizon, f'start_{unique_id}_{resource}')
                end_expr = start_var + duration
                presence_var = model.NewBoolVar(f'presence_{unique_id}_{resource}')

                interval_var = model.NewOptionalIntervalVar(
                    start_var, duration, end_expr, presence_var, f'interval_{unique_id}_{resource}'
                )

                # Store the interval_var along with the others
                all_tasks[instance.id][task_name][resource] = (
                    start_var, end_expr, interval_var, presence_var
                )

            if task_name.endswith("_1"):
                print("Stop")

            # Exactly one resource option must be chosen
            model.Add(sum(opt[3] for opt in all_tasks[instance.id][task_name].values()) == 1)

            
        for task_name in instance.get_task_list():
            successors = instance.get_successors(task_name)
            for succ in successors:
                # Add all precedence constraints for this task_name and its successors
                # Only adds precedence constraints for this instance's tasks, not across instances
                # The end date of task_name must be > the start date of succ
                current_task_options = all_tasks[instance.id][task_name].values()
                if succ not in all_tasks[instance.id]:
                    # Successor {succ} not found in tasks for instance {instance_id}. Skipping precedence constraint.")
                    continue
                successor_task_options = all_tasks[instance.id][succ].values()

                for current_task_opt in current_task_options:
                    for successor_task_opt in successor_task_options:
                        # If both options are present, then we add the precedence constraint
                        model.Add(successor_task_opt[0] >= current_task_opt[1]).OnlyEnforceIf(
                            [successor_task_opt[3], current_task_opt[3]]
                        )

    # Add no overlap constraints for tasks that share the same resource
    for res in all_resources:
        resource_intervals = []
        for instance_id, task_dict in all_tasks.items():
            for task_name, task_info in task_dict.items():
                if res in task_info:
                    # Pull the interval_var we stored (index 3)
                    _, _, interval_var, _ = task_info[res]
                    resource_intervals.append(interval_var)
        
        if resource_intervals:
            # CP-SAT handles the "optional" part automatically
            model.AddNoOverlap(resource_intervals)

    if objective == 'makespan':
        # Objective: Minimize makespan (end of the latest finishing task).
        # Only enforce the bound for the chosen resource option (presence_var == 1).
        makespan = model.NewIntVar(0, horizon, 'makespan')
        for instance_id, task_dict in all_tasks.items():
            for task_name, task_info in task_dict.items():
                for res, (start_var, end_var, interval_var, presence_var) in task_info.items():
                    model.Add(end_var <= makespan).OnlyEnforceIf(presence_var)
        model.Minimize(makespan)

    elif objective == 'flow_time':
        # Objective: Minimize average flow time
        # Flow time = end time - start time for each task
        flow_times = []
        for instance_id, task_dict in all_tasks.items():
            for task_name, task_info in task_dict.items():
                for res, (start_var, end_var, is_present, interval_var) in task_info.items():
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
        return solver, all_tasks
    elif status == cp_model.INFEASIBLE:
        print("No feasible schedule found (infeasible).")
        return None
    else:
        print("Timeout.")
        return None   


def run_scheduler(xes_path, petri_path, assignment_path):
# create a schedule_instance object
    sched_instances = []

    for i in os.listdir(xes_path):
        if not i.endswith(".xes"):
            continue
        current_instance = os.path.join(os.path.abspath(xes_path),i)
        instance_name = str(i).replace("problem", "").replace(".xes", "")
        sched_instance = ScheduleInstance(xes_path=current_instance, 
                                        petri_net_pnml_path=petri_path, 
                                        output_path="output_files/schedule_instance_output", 
                                        instance_id=Path(current_instance).stem + f'_{instance_name}')
        sched_instances.append(sched_instance)

    resource_repository = ResourceRepository(assignment_path)
    # You can add multiple dependency dicts to this list to schedule multiple instances
    result = solve_schedule(schedule_instances=sched_instances, 
                            resource_repository=resource_repository, 
                            timeout=30, 
                            objective='makespan')
    
    if result:
        solver, all_tasks = result

        prepared_tasks = prepare_all_tasks(solver, all_tasks)
        visualize_schedule_plotly(solver, prepared_tasks)
        export_highest_slack_instance(solver, prepared_tasks, sched_instances, output_path=os.path.abspath("input_files/slack_analysis_output/highest_slack_instance.json"))
        return result

def prepare_all_tasks(solver, all_tasks):
    """
    Transforms the `all_tasks` structure returned by `solve_schedule` into the
    format expected by `visualize_schedule_plotly`.

    solve_schedule format:
        all_tasks[instance_id][task_name][resource] = (start_var, end_expr, interval_var, presence_var)

    visualize_schedule_plotly format:
        all_tasks[instance_id][task_name] = (start_var, end_var, interval_var, res, release_time)

    For each task the chosen resource (presence_var == 1) is selected and the
    tuple is reshaped accordingly.  `release_time` is set to 0 because it is
    not part of the solver variables and is not used by the visualizer.
    """
    prepared = collections.defaultdict(dict)

    for instance_id, task_dict in all_tasks.items():
        for task_name, resource_options in task_dict.items():
            for res, (start_var, end_var, interval_var, presence_var) in resource_options.items():
                if solver.Value(presence_var) == 1:
                    prepared[instance_id][task_name] = (start_var, end_var, interval_var, res, 0)
                    break  # exactly one resource is chosen per task

    return prepared


if __name__ == "__main__":
    XES_DIR = "best_config"
    PETRI_PATH = "input_files/petri_net/a20g6.pnml"
    ASSIGNMENTS_PATH = "input_files/assignments/a20g6_assignments_t.json"
    
    run_scheduler(XES_DIR, PETRI_PATH, ASSIGNMENTS_PATH)