from pathlib import Path
import json
import pandas as pd

class ResourceRepository:
    def __init__(self, resource_file_path:str):
        self.resource_file_path = Path(resource_file_path)
        self.assignments = self._load_assignments()
        
    def _load_assignments(self) -> pd.DataFrame:
        if not self.resource_file_path.exists():
            raise FileNotFoundError(f"Resource file not found at {self.resource_file_path}")
        return pd.DataFrame(json.load(open(self.resource_file_path, 'r')))
    
    def get_resource_for_task(self, task_name:str) -> list:
        resources = self.assignments[self.assignments['task'] == task_name]['resource'].unique()
        if len(resources) > 1: 
            raise ValueError(f"Multiple resources found for task {task_name}. Please ensure each task is performed by a single resource in the resource file.")
        if len(resources) == 0:
            raise ValueError(f"No resources found for task {task_name}. Please ensure the task exists in the resource file.")
        return resources[0]
    
    def get_duration_for_assignment(self, task_name:str, resource_name:str) -> int:
        assignment = self.assignments[(self.assignments['task'] == task_name) & (self.assignments['resource'] == resource_name)]
        if len(assignment) == 0:
            raise ValueError(f"No assignment found for task {task_name} and resource {resource_name}. Please ensure the combination exists in the resource file.")
        if len(assignment) > 1:
            raise ValueError(f"Multiple assignments found for task {task_name} and resource {resource_name}. Please ensure each task-resource combination is unique in the resource file.")
        return assignment['duration'].iloc[0]
    
    def get_all_resources(self) -> list:
        return self.assignments['resource'].unique().tolist()