from pathlib import Path
import pm4py
import uuid

from src.pn_to_pt.pn_to_pt import load_petri_net, save_pt, pn_to_pt, save_pn_visualization, save_pt_visualization
from src.pt_to_sched.pt_to_sched import walk_tree, align_dependencies_with_log, save_as_json, load_instance_log

class ScheduleInstance:
    def __init__(self, xes_path: str, 
                 petri_net_pnml_path: str,
                 output_path: str = "output_files/schedule_instance_output", 
                 instance_id: str = None
                 ):
    
        if not isinstance(xes_path, str) or not isinstance(petri_net_pnml_path, str):
            raise TypeError("Expected both xes_path and petri_net_pnml_path to be strings.")
        self.id = instance_id if instance_id else uuid.uuid4().hex
        self.xes_path = Path(xes_path)
        self.petri_net_pnml_path = Path(petri_net_pnml_path)
        self.log = self._set_log()
        
        self.output_path = Path(output_path)
        self.output_path.parent.mkdir(parents=True, exist_ok=True)
        
        self.dependency_list = self._create_dependency_dict()
    
    def _create_dependency_dict(self) -> dict:
        net, im, fm = load_petri_net(self.petri_net_pnml_path)
        pt = pn_to_pt(net, im, fm)
        pt_output_path = self.output_path / Path("process_tree").with_suffix('.ptml')
        save_pt(pt, pt_output_path)
        # add pt or pn into Output path
        save_pt_visualization(pt, self.output_path / Path("process_tree").with_stem("process_tree-pt"))
        save_pn_visualization(net, im, fm, self.output_path / Path("petri_net").with_stem("process_tree-pn"))

        # create dependency dict
        dependencies = walk_tree(pt)
        log = load_instance_log(self.xes_path)
        align_dependencies = align_dependencies_with_log(pt, dependencies, log)
        output_path = self.output_path / Path("dependencies.json")
        save_as_json(align_dependencies, output_path)
        
        return align_dependencies
    
    def _set_log(self):
        """Sets self.log to a pm4py log object with unrolled loops."""
        df = pm4py.read_xes(str(self.xes_path))

        # Unroll loops by appending a suffix to repeated activities within the same case
        df['counter'] = df.groupby(['case:concept:name', 'concept:name']).cumcount()

        def append_suffix(row):
            if row['counter'] > 0:
                return f"{row['concept:name']}_{row['counter']}"
            return row['concept:name']

        df['concept:name'] = df.apply(append_suffix, axis=1)
        df = df.drop(columns=['counter'])
        return pm4py.convert_to_event_log(df)
        
    def get_task_list(self) -> list:
        df = pm4py.convert_to_dataframe(self.log)
        task_list = set(df['concept:name'].unique())
        return list(task_list)

    def get_resource_for_task(self, task_name:str) -> list:
        df = pm4py.convert_to_dataframe(self.log)
        resources = df[df['concept:name'] == task_name]['org:resource'].unique()
        if len(resources) > 1: 
            raise ValueError(f"Multiple resources found for task {task_name}. Please ensure each task is performed by a single resource in the log.")
        if len(resources) == 0:
            raise ValueError(f"No resources found for task {task_name}. Please ensure the task exists in the log.")
        return resources[0]
    
    def get_predecessors(self, task_name:str) -> list:
        predecessors = []
        for pred, succ in self.dependency_list:
            # Initialize if new
            if str(succ) == task_name:
                predecessors.append(str(pred))
            
        return predecessors
    
    def get_successors(self, task_name:str) -> list[str]:
        successors = []
        for pred, succ in self.dependency_list:
            # Initialize if new
            if str(pred) == task_name:
                successors.append(str(succ))
            
        return successors
    
    def get_task_for_resource(self, resource_name:str) -> list:
        df = pm4py.convert_to_dataframe(self.log)
        tasks = df[df['org:resource'] == resource_name]['concept:name'].unique()
        return tasks.tolist()

