import json
from pathlib import Path
import pm4py
from pm4py.objects.process_tree.obj import ProcessTree

def load_process_tree(input_path: str|Path):
    input_path = Path(input_path)
    # Check if ptml file
    if input_path.suffix != '.ptml':
        raise ValueError(f"Input file must be a .ptml file, got {input_path.suffix}")
    pt = pm4py.read_ptml(str(input_path))
    return pt

def get_task_list(pt:ProcessTree):
    leaf_list = pt._get_leaves()
    return [leaf.label for leaf in leaf_list]

def generate(pt: ProcessTree, no_resource:int=3, task_duration:int=10, seed:int=42):
    # get task list
    task_list = get_task_list(pt)
    # generate resource list
    resource_list = [f"R{i}" for i in range(no_resource)]
    # assign each task to a random resource
    import random
    random.seed(seed)
    task_resource_mapping = {task: random.sample(resource_list, random.randint(1, len(resource_list))) for task in task_list}

    task_resourece_mapping_zip = [(key, val) for key, values in task_resource_mapping.items() for val in values]

    assignments = []
    for task, resource in task_resourece_mapping_zip:
        duration = random.randint(1, task_duration)
        assignment = {
            "task": task,
            "resource": resource,
            "duration": duration
        }
        assignments.append(assignment)
    return assignments

def save_as_json(assignments, output_path: str|Path):
    output_path = Path(output_path)
    output_path.parent.mkdir(parents=True, exist_ok=True)

    # Check if output path is a .json file
    if output_path.suffix != '.json':
        output_path = output_path.with_suffix('.json')
    
    with open(output_path, 'w') as f:
        json.dump(assignments, f, indent=4)

if __name__ == "__main__":
    PT_INPUT_PATH = Path("output_files/petri_net/a20g6.ptml")
    OUTPUT_PATH = Path("output_files/assignments/a20g6_assignments.json")
    
    pt = load_process_tree(PT_INPUT_PATH)
    assignments = generate(pt)
    save_as_json(assignments, OUTPUT_PATH)