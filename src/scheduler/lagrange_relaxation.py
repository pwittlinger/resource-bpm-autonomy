import json
from pathlib import Path
#import resource

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

    for instance_id, task_dict in all_tasks.items():
        for task_name, task_info in task_dict.items():
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
    """Calculate cost metrics for each task-resource assignment.

    For every (task, resource) pair stores:
        additional_cost: duration − best_duration across all resources for this
                         task.  0 for the cheapest resource, positive for others.
        num_alternatives: how many resources can perform this task.
        is_only_resource: True when there is exactly one resource option.
        alternative_resources: list of *other* resource names for this task.

    Returns:
        dict: Nested structure {resource_name: {task_name: {…}}}
    """
    regret_values = {}
    for instance_id, task_dict in all_tasks.items():
        regret_values.setdefault(instance_id, {})
        for candidate_task in resource_repository.get_all_tasks():
            assignments = []
            for resource in resource_repository.get_resources_for_task(candidate_task):
                duration = resource_repository.get_duration_for_assignment(candidate_task, resource)
                assignments.append({"res": resource, "dur": duration})

            assignments.sort(key=lambda x: x['dur'])

            num_alternatives = len(assignments)
            is_only_resource = num_alternatives == 1
            best_dur = assignments[0]['dur']
            all_resource_names = [a['res'] for a in assignments]

            for a in assignments:
                res_name = a['res']
                additional_cost = a['dur'] - best_dur
                if candidate_task not in all_tasks[instance_id]:
                    currently_assigned = False
                else:
                    currently_assigned = all_tasks[instance_id][candidate_task][3] == res_name
                regret_values[instance_id].setdefault(res_name, {})
                regret_values[instance_id][res_name][candidate_task] = {
                    "additional_cost": float(round(additional_cost, 4)),
                    "num_alternatives": num_alternatives,
                    "is_only_resource": is_only_resource,
                    "alternative_resources": [r for r in all_resource_names if r != res_name],
                    "cost": int(a['dur']),
                    "currently_assigned": currently_assigned
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
    all_tasks: AllTasks,
    makespan: int,
    alpha: float = 1.0,
) -> dict[str, float]:
    """Calculates a task-specific tax driven purely by utilization and option count.

    Tax formula per (resource, task) pair:
        tax = utilization³ × (num_alternatives − 1) × alpha

    - High utilization → high tax (push work away from overloaded resources).
    - Many alternatives  → high tax (easy to redistribute).
    - Only one resource   → tax = 0  (nowhere to move the task).
    """

    for instance_id, resource_dict in single_resource_regret.items():
        for resource, tasks in resource_dict.items():
            utilization = resource_stats[resource]['utilization']
            utilization_pressure = (utilization ** 3) * alpha

            for task, data in tasks.items():
                """
                if task == 'ActivityT':
                    print("Stop")
                num_alt = data.get('num_alternatives', 1)

                if num_alt <= 1:
                    data['task_specific_tax'] = 0.0
                    continue

                normalized_cost = (
                    data['additional_cost'] / max_additional_cost
                    if max_additional_cost > 0
                    else 0.0
                )
                tax = utilization_pressure * (num_alt) * (1 + normalized_cost)
                data['task_specific_tax'] = tax
                """

                used_capacity = resource_stats[resource]['total_assigned_duration'] - data['cost'] if data['currently_assigned'] else resource_stats[resource]['total_assigned_duration']
                res_makespan = resource_stats[resource]['total_assigned_duration'] + data['cost'] if not data['currently_assigned'] else resource_stats[resource]['total_assigned_duration']
                shifted_makespan = max(makespan, res_makespan)
                tax = shifted_makespan / max((makespan - used_capacity), 0.1)
                data['task_specific_tax'] = tax

        
        for resource, stats in resource_stats.items():
            stats.setdefault(instance_id, {})
            stats[instance_id]['tasks'] = single_resource_regret[instance_id][resource]

    #plot_regret_rates(max_additional_cost, alpha, resource_stats)

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
    base_keys = {"total_assigned_duration", "utilization"}
    resources: dict[str, dict] = {}
    for resource, stats in resource_stats.items():
        instances = {
            key: {"tasks": value.get("tasks", {})}
            for key, value in stats.items()
            if key not in base_keys and isinstance(value, dict)
        }
        resources[resource] = {
            "total_assigned_duration": stats["total_assigned_duration"],
            "utilization": stats["utilization"],
            "contention_index": (
                round(stats["utilization"] / ideal_utilization, 4)
                if ideal_utilization > 0
                else 0.0
            ),
            "penalty_rate": penalty_rates[resource],
            "instances": instances,
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
        resource_stats, single_resource_regret, all_tasks, makespan, alpha=scaling_factor
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
