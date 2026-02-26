import json
from pathlib import Path


# ---------------------------------------------------------------------------
# Type aliases for readability
# ---------------------------------------------------------------------------
# {instance_id: {task_name: (start_var, end_var, interval_var, resource, release_time)}}
AllTasks = dict[str, dict[str, tuple]]
# {instance_id: {task_name: int}}
SlackMap = dict[str, dict[str, int]]
# {instance_id: list[task_name]}
CriticalTaskMap = dict[str, list[str]]


def _compute_successor_slack(solver, all_tasks: AllTasks, ref_instance) -> SlackMap:
    """For each task compute the gap between its end and the earliest successor start.

    A value of 0 means the task lies on the critical path.
    Tasks with no successors are assigned 0 (implicitly critical).
    """
    slack: SlackMap = {}
    for instance_id, task_dict in all_tasks.items():
        slack[instance_id] = {}
        for task_name, task_info in task_dict.items():
            end_time = solver.Value(task_info[1])  # index 1 = end_var

            valid_succs = [
                s for s in ref_instance.get_successors(task_name)
                if s in task_dict
            ]
            if valid_succs:
                min_succ_start = min(
                    solver.Value(all_tasks[instance_id][s][0]) for s in valid_succs
                )
                slack[instance_id][task_name] = min_succ_start - end_time
            else:
                slack[instance_id][task_name] = 0
    return slack


def _identify_critical_tasks(successor_slack: SlackMap) -> CriticalTaskMap:
    """Return tasks with zero successor-slack (i.e. on the critical path)."""
    return {
        instance_id: [task for task, slack in task_slack.items() if slack == 0]
        for instance_id, task_slack in successor_slack.items()
    }


def _compute_predecessor_slack(solver, all_tasks: AllTasks, ref_instance) -> SlackMap:
    """For each task compute the idle gap between the latest predecessor's end
    and the task's own start.  Tasks without predecessors use their release time
    as the reference point.
    """
    task_list = ref_instance.get_task_list()
    slack: SlackMap = {}
    for instance_id, task_dict in all_tasks.items():
        slack[instance_id] = {}
        for task_name, task_info in task_dict.items():
            start_var, _end_var, _interval, _resource, release_time = task_info
            start_time = solver.Value(start_var)

            predecessors = [
                t for t in task_list
                if task_name in ref_instance.get_successors(t) and t in task_dict
            ]

            if predecessors:
                max_pred_end = max(
                    solver.Value(all_tasks[instance_id][p][1]) for p in predecessors
                )
                slack[instance_id][task_name] = start_time - max_pred_end
            else:
                slack[instance_id][task_name] = start_time - release_time
    return slack


def _accumulated_slack_per_instance(
    predecessor_slack: SlackMap,
    critical_tasks: CriticalTaskMap,
) -> dict[str, int]:
    """Sum predecessor-slack over critical tasks only for every instance."""
    return {
        instance_id: sum(
            slack
            for task, slack in task_slack.items()
            if task in critical_tasks.get(instance_id, [])
        )
        for instance_id, task_slack in predecessor_slack.items()
    }


def _find_highest_slack_instance(accumulated: dict[str, int]) -> str:
    """Return the instance_id with the largest accumulated slack."""
    return max(accumulated, key=accumulated.get)


def _build_report(
    instance_id: str,
    accumulated: dict[str, int],
    critical_tasks: CriticalTaskMap,
    predecessor_slack: SlackMap,
) -> dict:
    """Assemble the report dict for the given instance."""
    tasks = [
        {
            "task": task_name,
            "predecessor_slack": predecessor_slack[instance_id].get(task_name, 0),
        }
        for task_name in critical_tasks.get(instance_id, [])
    ]
    tasks.sort(key=lambda t: -t["predecessor_slack"])

    return {
        "instance_id": instance_id,
        "accumulated_slack": accumulated[instance_id],
        "tasks": tasks,
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

def export_highest_slack_instance(
    solver,
    all_tasks: AllTasks,
    sched_instances: list,
    output_path: str = "output_files/highest_slack_instance.json",
) -> dict:
    """Identify the instance with the highest accumulated critical-task slack
    and write a JSON report to *output_path*.

    Args:
        solver:          Solved CP-SAT solver object.
        all_tasks:       Nested dict mapping instance_id → task_name →
                         (start_var, end_var, interval_var, resource, release_time).
        sched_instances: List of ScheduleInstance objects; the first entry is used
                         as the process-topology reference (all instances share the
                         same model structure).
        output_path:     Destination path for the JSON report.

    Returns:
        The report dict that was written to disk.
    """
    # All instances share the same process topology — use the first as reference.
    ref_instance = sched_instances[0]

    successor_slack = _compute_successor_slack(solver, all_tasks, ref_instance)
    critical_tasks = _identify_critical_tasks(successor_slack)
    predecessor_slack = _compute_predecessor_slack(solver, all_tasks, ref_instance)
    accumulated = _accumulated_slack_per_instance(predecessor_slack, critical_tasks)

    best_id = _find_highest_slack_instance(accumulated)
    print(
        f"\nInstance with highest accumulated slack: {best_id} "
        f"(total slack = {accumulated[best_id]})"
    )

    report = _build_report(best_id, accumulated, critical_tasks, predecessor_slack)
    path = _write_report(report, output_path)
    print(f"Slack report written to {path}")

    return report
