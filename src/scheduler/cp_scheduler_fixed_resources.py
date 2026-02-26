import collections
from ortools.sat.python import cp_model
import sys
from pathlib import Path

# Add parent directories to path
sys.path.insert(0, str(Path(__file__).parent.parent.parent))

from src.scheduler.resource_repository import ResourceRepository
from src.scheduler.schedule_instance import ScheduleInstance
from src.scheduler.plotly_visualizer import visualize_schedule_plotly
from src.scheduler.slack_analysis import export_highest_slack_instance

def solve_schedule(schedule_instances: list,
                   resource_repository: ResourceRepository,
                   top_n_instances=10, 
                   timeout=100, 
                   objective='makespan'
                   ):
    
    model = cp_model.CpModel()
    # Horizon is the upper Bound. Sum of all task durations is a safe upper bound on the schedule length.
    horizon = 0
    for instance in schedule_instances:
        for task_name in instance.get_task_list():
            resource = instance.get_resource_for_task(task_name)
            duration = resource_repository.get_duration_for_assignment(task_name, resource)
            # We can sum durations across all tasks and instances to get a safe upper bound for the horizon
            horizon += duration

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
    resource_map = collections.defaultdict(list)

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
            end_expr = start_var + duration

            interval_var = model.NewIntervalVar(
                start_var, duration, end_expr, f'interval_{unique_id}_{resource}'
            )

            # Store the interval_var along with the others
            all_tasks[instance.id][task_name] = (
                start_var, end_expr, interval_var, resource, release_time
            )
            resource_map[resource].append(interval_var)

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
        
    # Add no-overlap constraints for each resource
    for res_intervals in resource_map.values():
        model.AddNoOverlap(res_intervals)

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
        # Flow time = end time of instance - release time of instance
        total_flow_time = []
        for instance_id, task_dict in all_tasks.items():
            start_vars = [vars[4] for vars in task_dict.values()]  # release_time is at index 4
            end_vars = [vars[1] for vars in task_dict.values()]    # end_var is at index 1
            start_min = model.NewIntVar(0, horizon, f'start_{instance_id}')
            end_max = model.NewIntVar(0, horizon, f'end_{instance_id}')
            model.AddMinEquality(start_min, start_vars)
            model.AddMaxEquality(end_max, end_vars)
            
            # Flow time for this instance
            flow_time = model.NewIntVar(0, horizon, f'flow_{instance_id}')
            model.Add(flow_time == end_max - start_min)
            total_flow_time.append(flow_time)

        # Minimize SUM (Faster than Division)
        model.Minimize(sum(total_flow_time))
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

        #for flow_time in total_flow_time:
            #print(f"Flow time for instance: {solver.Value(flow_time)}")
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
    for i in range(15):
        sched_instance = ScheduleInstance(xes_path=INSTANCES_PATH, 
                                        petri_net_pnml_path=PETRI_PATH, 
                                        output_path="output_files/schedule_instance_output")
        sched_instances.append(sched_instance)

    resource_repository = ResourceRepository(ASSIGNMENTS_PATH)
    # You can add multiple dependency dicts to this list to schedule multiple instances
    result = solve_schedule(schedule_instances=sched_instances, 
                            resource_repository=resource_repository, 
                            timeout=30, 
                            objective='makespan')
    
    if result:
        solver, all_tasks = result
        visualize_schedule_plotly(solver, all_tasks)
        export_highest_slack_instance(solver, all_tasks, sched_instances)

