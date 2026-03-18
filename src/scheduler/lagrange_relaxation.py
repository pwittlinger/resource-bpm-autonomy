import json
from pathlib import Path
import resource

from src.scheduler.resource_repository import ResourceRepository
from src.scheduler.helper import plot_regret_rates


# ---------------------------------------------------------------------------
# Type aliases for readability
# ---------------------------------------------------------------------------
# {instance_id: {task_name: (start_var, end_var, interval_var, resource, release_time)}}
AllTasks = dict[str, dict[str, tuple]]


# ---------------------------------------------------------------------------
# Internal helpers
# ---------------------------------------------------------------------------


def _compute_makespan(solver, all_tasks: AllTasks) -> int:
    """Return the maximum end time across all tasks and all instances."""
    makespan = 0
    for task_dict in all_tasks.values():
        for task_info in task_dict.values():
            end_time = solver.Value(task_info[1])  # end_var at index 1
            if end_time > makespan:
                makespan = end_time
    return makespan


def _compute_resource_stats(
    solver,
    all_tasks: AllTasks,
    makespan: int,
) -> dict[str, dict]:
    """Accumulate total assigned duration (Step A) and utilization for every resource.

    Returns a dict keyed by resource name with keys:
        total_assigned_duration: sum of durations of all tasks assigned to this resource
        utilization:             total_assigned_duration / makespan
    """
    resource_stats: dict[str, dict] = {}

    for task_dict in all_tasks.values():
        for task_info in task_dict.values():
            start_time = solver.Value(task_info[0])  # start_var at index 0
            end_time = solver.Value(task_info[1])  # end_var   at index 1
            resource = task_info[3]  # resource  at index 3
            duration = end_time - start_time

            if resource not in resource_stats:
                resource_stats[resource] = {"total_assigned_duration": 0}
            resource_stats[resource]["total_assigned_duration"] += duration

    for stats in resource_stats.values():
        stats["utilization"] = (
            round(stats["total_assigned_duration"] / makespan, 4)
            if makespan > 0
            else 0.0
        )

    return resource_stats


def _compute_simple_regret_values(
    solver,
    all_tasks: AllTasks,
    resource_repository: ResourceRepository,
    makespan: int,
) -> dict[str, float]:
    """Calculate regret metric for each task-resource assignment.
    The regret is the difference between the duration of the assigned resource and 
    the best possible assignment for that task.

    A high regret value indicates that the assigned resource is slower than the best option,
    a regret value of 0 indicates the best possible assignment.

    Returns:
        dict: Nested structure {resource_name: {task_name: {'regret': float}}}
    """
    regret_values = {}
    for candidate_task in resource_repository.get_all_tasks():
        possible_assignments = []
        for resource in resource_repository.get_resources_for_task(candidate_task):
            # Get each assignment (task, resource, duration)
            duration = resource_repository.get_duration_for_assignment(candidate_task, resource)
            possible_assignments.append((candidate_task, resource, duration))
            regret_values.setdefault(resource, {})
        
        for assignment in possible_assignments:
            # Calculate regret for each of the assignments for this task
            # We calculate regret as best resource duration - average of all other possible resource durations for this task
            best_assignment = min(possible_assignments, key=lambda x: x[2])  # assignment with lowest duration
            other_assignments = [
                a for a in possible_assignments if a != assignment
            ]

            regret = (
                assignment[2]
                - best_assignment[2]
            )

            # Add to regret_values dict
            # for best assignment
            regret_values[assignment[1]][assignment[0]] = {
                "regret": int(round(regret, 4))
            }

    return regret_values


def _compute_penalty_rates(
    resource_stats: dict[str, dict],
    makespan: int,
    ideal_utilization: float,
    scaling_factor: float,
) -> dict[str, float]:
    """Compute the time-agnostic penalty rate πr for each resource (Step B).

        πr = max(0, total_assigned_duration_r − ideal_utilization × makespan) × scaling_factor

    Resources whose utilization stays below the ideal threshold receive πr = 0.
    Overloaded resources receive a positive penalty proportional to the excess duration.
    """
    penalty_rates: dict[str, float] = {}
    for resource, stats in resource_stats.items():
        target_capacity = ideal_utilization * makespan
        excess = stats["total_assigned_duration"] - target_capacity
        penalty_rates[resource] = round(max(0.0, excess) * scaling_factor, 6)
    return penalty_rates

def _compute_regret_rates(
    resource_stats: dict[str, dict],
    single_resource_regret: dict[str, dict],
    makespan: int,
    alpha: float = 1.0,
) -> dict[str, float]:
    """Calculates a task specific tax rate. 
    The task rate is calculated by taing the resource utilizaioton * normalized_regret_for task.
    
    This task specific tax therefore should balance utilization and only move tasks away from a 
    constrained resource if the regret of the assignment is low.
    """
    
    # Get maximal regret value across all resources and tasks to use for normalization
    max_regret = max(
        data['regret'] for resource_data in single_resource_regret.values()
        for data in resource_data.values()
    )
    if not max_regret:
        max_regret = 0
    for resource in single_resource_regret.keys():
        lambda_r = resource_stats[resource]['utilization'] * alpha
        
        for task, data in single_resource_regret[resource].items():
            regret = data['regret']
            # normalize regret
            normalized_regret = max(regret/max_regret, 0.00001)
            task_specific_tax = lambda_r * (1+normalized_regret)

            single_resource_regret[resource][task]['task_specific_tax'] = task_specific_tax

    for resource, stats in resource_stats.items():
        stats['tasks'] = single_resource_regret[resource]

    # save a matplotlib visualization which shows, how the current alpha, 
    # utilization and max regret impact the curve
    plot_regret_rates(max_regret, alpha, resource_stats)
    
    return resource_stats

def _build_shadow_cost_report(
    makespan: int,
    resource_stats: dict[str, dict],
    penalty_rates: dict[str, float],
    ideal_utilization: float,
    scaling_factor: float,
) -> dict:
    """Assemble the full shadow-cost report dict.

    Each resource entry contains:
        total_assigned_duration: raw total duration (time units)
        utilization:             fraction of makespan occupied by this resource
        contention_index:        utilization / ideal_utilization
                                 (> 1.0 means the resource is over the target)
        penalty_rate:            πr to be used by the planner (Step C)
    """
    resources: dict[str, dict] = {}
    for resource, stats in resource_stats.items():
        resources[resource] = {
            "total_assigned_duration": stats["total_assigned_duration"],
            "utilization": stats["utilization"],
            "contention_index": (
                round(stats["utilization"] / ideal_utilization, 4)
                if ideal_utilization > 0
                else 0.0
            ),
            "penalty_rate": penalty_rates[resource],
            "tasks": stats["tasks"]
        }

    # Sort by penalty_rate descending so the most contended resources appear first
    resources = dict(
        sorted(resources.items(), key=lambda item: -item[1]["penalty_rate"])
    )

    return {
        "makespan": makespan,
        "ideal_utilization": ideal_utilization,
        "scaling_factor": scaling_factor,
        "resources": resources,
    }


def _write_report(report: dict, output_path: str) -> Path:
    """Write *report* as JSON to *output_path* and return the resolved Path."""
    path = Path(output_path)
    path.parent.mkdir(parents=True, exist_ok=True)
    with open(path, "w") as f:
        json.dump(report, f, indent=2)
    return path


# ---------------------------------------------------------------------------
# Public entry point
# ---------------------------------------------------------------------------


def export_lagrange_shadow_costs(
    solver,
    all_tasks: AllTasks,
    resource_repository: ResourceRepository,
    output_path: str = "output_files/lagrange_shadow_costs.json",
    ideal_utilization: float = 0.80,
    scaling_factor: float = 1.0,
) -> dict:
    """Calculate shadow costs (penalty rates) for each resource after CP solving
    and write a JSON report to *output_path*.

    Intended to be called alongside ``export_highest_slack_instance`` right after
    ``solve_schedule`` returns a solution.

    Algorithm
    ---------
    Step A – Resource Contention Index:
        For every resource, sum the durations of all scheduled tasks assigned to it
        across all instances.  Divide by the global makespan to get utilisation.

    Step B – Time-Agnostic Penalty Rate:
        πr = max(0, total_assigned_duration_r − ideal_utilization × makespan) × scaling_factor

        Resources below the ideal threshold get πr = 0; overloaded resources get
        a positive penalty proportional to the excess work.

    Step C – Planner Integration (for reference):
        Reduced Cost = Base Cost + Σ(task_duration × πr)
        The planner multiplies each task duration by the penalty rate of the
        assigned resource.  This naturally steers it away from over-utilised
        resources, even when those resources have shorter base durations.

    Args:
        solver:            Solved CP-SAT solver object.
        all_tasks:         Nested dict mapping
                           instance_id → task_name →
                           (start_var, end_var, interval_var, resource, release_time).
        output_path:       Destination path for the JSON report.
        ideal_utilization: Target utilisation rate per resource in [0, 1].
                           Resources above this threshold are penalised.
                           Default: 0.8.
        scaling_factor:    Multiplier applied to the raw excess to produce πr.
                           Increase to make the planner more sensitive to contention.
                           Default: 1.0.

    Returns:
        The report dict that was written to disk.
    """
    makespan = _compute_makespan(solver, all_tasks)
    resource_stats = _compute_resource_stats(solver, all_tasks, makespan)

    single_resource_regret = _compute_simple_regret_values(
        solver, all_tasks, resource_repository, makespan
    )
    _write_report(single_resource_regret, "output_files/lagrange_single_resource_regret.json")

    penalty_rates = _compute_penalty_rates(
        resource_stats, makespan, ideal_utilization, scaling_factor
    )

    resource_stats = _compute_regret_rates(
        resource_stats, single_resource_regret, makespan, alpha=0.5
    )

    report = _build_shadow_cost_report(
        makespan, resource_stats, penalty_rates, ideal_utilization, scaling_factor
    )
    path = _write_report(report, output_path)

    print(f"\nResource shadow costs written to {path}")
    for resource, data in report["resources"].items():
        print(
            f"  {resource}: utilization={data['utilization']:.2%}, "
            f"contention_index={data['contention_index']:.3f}, "
            f"penalty_rate={data['penalty_rate']}"
        )

    return report
