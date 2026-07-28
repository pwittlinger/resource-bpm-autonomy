"""Data model for solved schedules."""

import json
from dataclasses import dataclass, field
from pathlib import Path
from typing import ClassVar


TASK_FIELDS = {
    "Instance_id",
    "Resource",
    "Task",
    "Start",
    "Finish",
    "Duration",
}


@dataclass
class ScheduleData:
    """A solver-independent, persistable representation of a schedule."""

    tasks: list[dict[str, str | int]]
    makespan: int
    name: str | None = None
    resources: list[str] = field(default_factory=list)

    SCHEMA_VERSION: ClassVar[int] = 1

    def __post_init__(self):
        allocated_resources = [
            str(task["Resource"])
            for task in self.tasks
        ]
        self.resources = self._normalize_resources(
            [*self.resources, *allocated_resources]
        )

    @property
    def max_finish(self):
        """Return the latest finish time in this schedule."""
        return max((task["Finish"] for task in self.tasks), default=0)

    @classmethod
    def from_solver(cls, solver, all_tasks, name=None, resources=None):
        """Build schedule data from an OR-Tools solver and its task variables."""
        tasks = []

        for instance_id, task_dict in all_tasks.items():
            for task_name, task_info in task_dict.items():
                start_var, end_var, _, resource, _ = task_info
                start = int(solver.Value(start_var))
                finish = int(solver.Value(end_var))
                tasks.append({
                    "Instance_id": str(instance_id),
                    "Resource": str(resource),
                    "Task": str(task_name),
                    "Start": start,
                    "Finish": finish,
                    "Duration": finish - start,
                })

        return cls(
            tasks=tasks,
            makespan=int(solver.ObjectiveValue()),
            name=name,
            resources=[] if resources is None else resources,
        )

    def to_dict(self):
        """Convert this schedule into its JSON-compatible representation."""
        return {
            "schema_version": self.SCHEMA_VERSION,
            "name": self.name,
            "makespan": self.makespan,
            "resources": self.resources,
            "tasks": self.tasks,
        }

    @classmethod
    def from_dict(cls, data):
        """Create schedule data from its JSON-compatible representation."""
        if isinstance(data, list):
            # Compatibility with schedule files created before ScheduleData
            # became a dedicated object.
            tasks = cls._normalize_tasks(data)
            makespan = max((task["Finish"] for task in tasks), default=0)
            return cls(tasks=tasks, makespan=makespan)

        if not isinstance(data, dict):
            raise ValueError("Schedule data must be a JSON object.")

        schema_version = data.get("schema_version")
        if schema_version != cls.SCHEMA_VERSION:
            raise ValueError(
                f"Unsupported schedule data schema version: {schema_version}."
            )

        if "tasks" not in data or "makespan" not in data:
            raise ValueError(
                "Schedule data must contain 'tasks' and 'makespan'."
            )

        return cls(
            tasks=cls._normalize_tasks(data["tasks"]),
            makespan=int(data["makespan"]),
            name=None if data.get("name") is None else str(data["name"]),
            resources=cls._normalize_resources(data.get("resources", [])),
        )

    def save(self, file_path):
        """Save this schedule to a persistent JSON file."""
        file_path = Path(file_path)
        file_path.parent.mkdir(parents=True, exist_ok=True)

        with file_path.open("w", encoding="utf-8") as file:
            json.dump(self.to_dict(), file, indent=2, ensure_ascii=False)

        return file_path

    @classmethod
    def load(cls, file_path):
        """Load a schedule from a persistent JSON file."""
        file_path = Path(file_path)

        with file_path.open("r", encoding="utf-8") as file:
            data = json.load(file)

        return cls.from_dict(data)

    @staticmethod
    def _normalize_tasks(tasks):
        if not isinstance(tasks, list):
            raise ValueError("Schedule tasks must be a list.")

        normalized_tasks = []
        for index, task in enumerate(tasks):
            if not isinstance(task, dict):
                raise ValueError(
                    f"Schedule task at index {index} must be an object."
                )

            missing_fields = TASK_FIELDS.difference(task)
            if missing_fields:
                missing = ", ".join(sorted(missing_fields))
                raise ValueError(
                    f"Schedule task at index {index} is missing: {missing}."
                )

            start = int(task["Start"])
            finish = int(task["Finish"])
            duration = int(task["Duration"])
            if finish - start != duration:
                raise ValueError(
                    f"Schedule task at index {index} has an invalid duration."
                )

            normalized_tasks.append({
                "Instance_id": str(task["Instance_id"]),
                "Resource": str(task["Resource"]),
                "Task": str(task["Task"]),
                "Start": start,
                "Finish": finish,
                "Duration": duration,
            })

        return normalized_tasks

    @staticmethod
    def _normalize_resources(resources):
        if not isinstance(resources, list):
            raise ValueError("Schedule resources must be a list.")
        return list(dict.fromkeys(str(resource) for resource in resources))
