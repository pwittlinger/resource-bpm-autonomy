from copy import deepcopy
import json
from pathlib import Path
import pm4py
from pm4py.objects.process_tree.obj import Operator, ProcessTree

def load_process_tree(input_path: str|Path):
    input_path = Path(input_path)
    # Check if ptml file
    if input_path.suffix != '.ptml':
        raise ValueError(f"Input file must be a .ptml file, got {input_path.suffix}")
    
    pt = pm4py.read_ptml(str(input_path))

    return pt

def load_instance_log(input_path: str|Path):
    input_path = Path(input_path)
    # Check if xes file
    if input_path.suffix != '.xes':
        raise ValueError(f"Input file must be a .xes file, got {input_path.suffix}")
    
    log = pm4py.read_xes(str(input_path))

    return log

def walk_tree(pt: ProcessTree):
    """Walk each branch of the process tree and return the dependency of two nodes"""
    root = pt
    dependencies = []
    for child in root.children:
        following_child = root.children[root.children.index(child) + 1] if root.children.index(child) + 1 < len(root.children) else None

        if root.operator == Operator.SEQUENCE:

            if child.operator != None and following_child != None:
                dependencies.extend(resolve_complex_dependency(child, following_child))
            elif following_child != None and following_child.operator != None:
                dependencies.extend(resolve_complex_dependency(following_child, child, flipped=True))
            else:
                if following_child != None:
                    dependencies.append((child, following_child))           
                   
        #if root.operator in [Operator.XOR, Operator.PARALLEL]:
        #    dependencies.extend(walk_tree(child))
            

        if root.operator == Operator.LOOP:            
            # add dependency between the last child of first branch and the first child of the second branch
            child_labels = [c.label for c in child.children]
            if not 'tau' in child_labels:
                if following_child != None:
                    dependencies.append((child.children[-1], following_child.children[0]))
        
        if child.operator != None:
            dependencies.extend(walk_tree(child))
    
    return dependencies

def resolve_complex_dependency(child, following_child, flipped=False):
    dependencies = []
    if child.operator == Operator.SEQUENCE:
        raise ValueError("A sequence should not have another sequence as child")
    elif child.operator in [Operator.XOR, Operator.PARALLEL, Operator.LOOP]:
        for c in child.children:
            # for each branch, get the last activity of a seq.
            if c.operator == Operator.SEQUENCE:
                if flipped:
                    dependencies.append((following_child, c.children[0]))
                else:
                    dependencies.append((c.children[-1], following_child))
            elif c.operator == None:
                if flipped:
                    dependencies.append((following_child, c))
                else:
                    dependencies.append((c, following_child))
            else:
                dependencies.extend(resolve_complex_dependency(c, following_child, flipped))
    else:
        raise NotImplementedError(f"Operator {child.operator} is not supported yet")
    return dependencies

def get_loop_pts(pt) -> list[ProcessTree]:
    loop_pts = []
    if pt.operator == Operator.LOOP:
        isolated_loop = deepcopy(pt)
        isolated_loop.parent = None
        loop_pts.append(isolated_loop)
    for child in pt.children:
        if child.operator != None:
            loop_pts.extend(get_loop_pts(child))
    return loop_pts

def unroll_loops_in_log(log, loop_activities):
    # For each trace, count the occurences of each activity in loop_activities.
    df = pm4py.convert_to_dataframe(log)
    counts_df = df.groupby(['case:concept:name', 'concept:name']).size().reset_index(name='count')
    counts_df = counts_df[counts_df['concept:name'].isin(loop_activities)]
    max_loop_count = counts_df['count'].max()
    return max_loop_count

def align_dependencies_with_log(pt, dependencies, log):
    # IF a loop arises in an instance, for each iteration of the loop, the dependecies
    # must be duplicated, the loop must be unrolled. and the number of unrolls must be added to the label

    # identify loops in pt
    loop_pts = get_loop_pts(pt)
    for loop_pt in loop_pts:
        loop_activity_labels = [c.label for c in loop_pt._get_leaves() if c.operator == None]
        max_loop_count = unroll_loops_in_log(log, loop_activity_labels)

        # unroll the loop in the dependencies
        loop_dependencies = []
        for d in dependencies:
            if len(d) == 0:
                continue
            if d[0].label in loop_activity_labels:
                loop_dependencies.append(d)
            elif d[1].label in loop_activity_labels:
                loop_dependencies.append(d)
            elif d[0].label in loop_activity_labels and d[1].label in loop_activity_labels:
                loop_dependencies.append(d)
        
        for i in range(1, max_loop_count):
            for d in loop_dependencies:
                new_d = deepcopy(d)
                if new_d[0].label in loop_activity_labels:
                    new_d = (new_d[0].label + f"_{i}", new_d[1])
                if new_d[1].label in loop_activity_labels:
                    new_d = (new_d[0], new_d[1].label + f"_{i}")
                dependencies.append(new_d)
        
            # all loop elements of n+1 run must be after all loop elements of n run
            for activity in loop_pt._get_leaves():
                new_activity = deepcopy(activity)
                new_activity.label = activity.label + f"_{i}"
                if i == 1:
                    dependencies.append((activity, new_activity))
                else:
                    old_activity = deepcopy(activity)
                    old_activity.label = activity.label + f"_{i-1}"
                    dependencies.append((old_activity, new_activity))

    return dependencies

if __name__ == "__main__":
    PT_INPUT_PATH = Path("output_files/a20g6.ptml")
    LOG_INPUT_PATH = Path("input_files/xes_files/a20g6_loop.xes")
    OUTPUT_PATH = Path("output_files/a20g6_dependencies.json")
    pt = load_process_tree(PT_INPUT_PATH)
    log = load_instance_log(LOG_INPUT_PATH)
    
    dependencies = walk_tree(pt)
    print(dependencies)

    aligned_dependencies = align_dependencies_with_log(pt, dependencies, log)
    dependency_dict = {"dependencies": aligned_dependencies}    
    with open(OUTPUT_PATH, 'w') as f:
        json.dump(dependency_dict, f, default=str, indent=2)
    print(aligned_dependencies)
    
    
    




    
