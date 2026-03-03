import sys
import time
import subprocess
import os
import random
import re
import json
import pm4py
import pandas as pd
import src.scheduler.cp_scheduler_fixed_resources as cp
import shutil


parent_path = os.path.abspath(os.getcwd())
output_folder = os.path.join(parent_path, "output", "pddl")


jar_path = "pddl_gen-1.0-SNAPSHOT-launcher.jar"
planner_path = os.path.join("planner", "enhsp.jar")#"planner\enhsp.jar"
domain_path = os.path.join("planner", "domain_framed_autonomy_resource.pddl")#"planner\domain_framed_autonomy_resource.pddl"
generated_plan_path = "generated_plans"
generated_xes_path = "generated_xes"
plan_parser = "ParsePlan.jar"
slack_instance = os.path.join("input_files","slack_analysis_output","highest_slack_instance.json")#"input_files/slack_analysis_output/highest_slack_instance.json"

cols = ["concept:name", "org:resource", "case:concept:name"]

def get_problem_path_from_id(id_to_search):
    return f"problem{id_to_search}.pddl"

def run_planner(problem_id):
    output_file = open(os.path.join(parent_path, generated_plan_path, f"problem{problem_id}.txt"), "w")
    call_array = ["java", "-jar",
                os.path.join(parent_path, planner_path),
                "-o", os.path.join(parent_path, domain_path),
                "-f", os.path.join(output_folder, get_problem_path_from_id(problem_id)),
                "-planner", "opt-blind"]
    
    r = subprocess.call(call_array, stdout=output_file)
    #print(r)

def generate_all_initial_plans():
    nProbs = len(os.listdir(output_folder))

    for i in range(nProbs):
        if not (os.path.isfile(os.path.join(parent_path, generated_plan_path, f"problem{i+1}.txt"))):
            print(f"Generating initial plan for problem{i+1}.pddl")
            run_planner(i+1)

def generate_all_xes_from_plan(decl_path,activity_mapping):
    nProbs = len(os.listdir(output_folder))

    for i in range(nProbs):
        if (os.path.isfile(os.path.join(parent_path, generated_plan_path, f"problem{i+1}.txt"))):
            print(f"Generating initial XES for problem{i+1}.pddl")
            generate_xes_from_plan(decl_path=decl_path, activity_mapping=activity_mapping, problem_id = i+1, initial=True)


def generate_xes_from_plan(decl_path,activity_mapping, problem_id, initial):
    """Converts the plan (.txt) into an actual XES file corresponding to the generated suffix.
    """
    generated_plan = os.path.join(parent_path, "generated_plans", f"problem{problem_id}.txt")

    if initial:
        xes_path = os.path.join(parent_path, "generated_xes", "initial", f"problem{problem_id}.xes")
        if os.path.isfile(xes_path):
            os.remove(xes_path)
    else:
        xes_path = os.path.join(parent_path, "generated_xes", "optim",f"problem{problem_id}.xes")
        if os.path.isfile(xes_path):
            os.remove(xes_path)

    call_array = ["java", "-jar",
                  os.path.join(parent_path, plan_parser),
                  decl_path, activity_mapping, generated_plan, xes_path
                  ]
    subprocess.call(call_array)

    if initial:
        shutil.copy(xes_path, os.path.join(parent_path, "generated_xes", f"problem{problem_id}.xes"))


def adjust_cost(problem_id, gap_file, activity_map_object):
    #[('ActivityA', 219), ('ActivityS', 17), ('ActivityM', 6)]

    gap = read_gap_file(os.path.join(parent_path, gap_file))

    gap_pairs = gap["tasks"]

    with open(os.path.join(output_folder, f"problem{problem_id}.pddl")) as pf:
        content = pf.read()
    
    # I need to look for the cost allocations and replace them
    # (= (activity_cost a7 R0) 3) -> (= (activity_cost a7 R0) 10)

    for g in gap_pairs:
        act = g["task"]
        res = g["resource"]
        cost = g["predecessor_slack"]

        repl_act = activity_map_object[act]
        

        #old = fr"\(= \(activity_cost (.*) {res}\) ([\d]+)\)"
        #old_cost = 0
        #new_content = content
        #for m in re.finditer(old, content):
        #    old_act = m.group(1)
        #    old_cost = m.group(2)
        #    updated_cost = int(old_cost) + 700
        #    new = f"(= (activity_cost {old_act} {res}) {updated_cost})"
        #    new_content = re.sub(re.escape(m.group()), new, new_content)

        old = fr"\(= \(activity_cost {repl_act} {res}\) ([\d]+)\)"
        old_cost = 0
        if find := re.search(old, content):
            old_cost = find.group(1)

        updated_cost = int(old_cost) + cost# + 700
        
        new = f"(= (activity_cost {repl_act} {res}) {updated_cost})"

        content = re.sub(old, new, content)

    with open(os.path.join(output_folder, f"problem{problem_id}.pddl"), "w") as pf:
        pf.write(content)
        #pf.write(new_content)

def read_gap_file(gap_file):
    with open(gap_file) as f:
        data = json.load(f)
    return data


def instantiate_mapping_file(activity_mapping):

    actmap = {}
    with open(activity_mapping) as mf:
        for line in mf:
            val = line.replace("\n", "").split(":")
            actmap[val[0]] = val[1]

    return actmap

def parse_input(args):

    decl_loc = os.path.join(parent_path,args[1])
    pn_loc = os.path.join(parent_path,args[6])
    l = os.path.join(parent_path,args[2])
    variable_values = os.path.join(parent_path,args[3])
    var_sub_loc = os.path.join(parent_path,args[4])
    cost_model = os.path.join(parent_path,args[5])

    return decl_loc, pn_loc, l, variable_values, var_sub_loc, cost_model


if __name__ == "__main__":
    print(sys.argv)
    # Stopping conditions for loop
    maxIterations = 25 # total number of iterations
    timeoutLimit = 300 # Maximum number of seconds spend

    # Read in file paths to generate PDDL files
    decl_loc, pn_loc, l, variable_values, var_sub_loc, cost_model = parse_input(sys.argv)

    # Setting variables to generate the XES later
    pn_name = os.path.normpath(pn_loc).split(os.sep)[-1]
    activity_mapping = os.path.join(parent_path, "output", f"activityMapping_{pn_name}.txt")

    act_map = instantiate_mapping_file(activity_mapping=activity_mapping)

    #slack_file = read_gap_file(os.path.join(parent_path, slack_instance))


    # Generate PDDL files
    # This creates files under the current path/output/pddl
    subprocess.call(['java', '-jar', jar_path, "-d", decl_loc, "-p", pn_loc, "-o", l, "-a",variable_values,"-s", var_sub_loc, "-c",cost_model])

    #
    generate_all_initial_plans()
    generate_all_xes_from_plan(decl_loc, activity_mapping)

    inrus = cp.run_schedule(os.path.join(parent_path, generated_xes_path), pn_loc, cost_model)

    initial_objective = inrus[0].BestObjectiveBound()

    # Instantiate the loop variables
    i = 0
    currentStart = time.time()
    currentIteration = 0
    same_trace = False
    same_trace_count = 0

    already_replanned = dict()
    best_ = initial_objective

    for i in range(len(os.listdir(output_folder))+1):
        already_replanned[i] = 0

    while ((i < maxIterations) and ((currentIteration-currentStart)<timeoutLimit)):
        # Update iteration counter
        i = i+1
        
        # At this step, I need to get the correct ID to replan
        # And I need to update the cost model of the plan.
        #id_to_plan = random.randint(0,9)+1
        gap = read_gap_file(os.path.join(parent_path, slack_instance))
        id_to_plan = int(gap["instance_id"].split("_")[1])

        if (id_to_plan not in already_replanned.keys()):
            already_replanned[id_to_plan] = 0

        if (already_replanned[id_to_plan] > 2):
            #already_replanned = set()
            id_to_plan = random.randint(0,9)+1
        
        if (not same_trace) or (same_trace_count > 2):

            #while id_to_plan in already_replanned:
            #    id_to_plan = random.randint(0,9)+1

            original_suffix = os.path.join(parent_path, generated_xes_path,"initial", f"problem{id_to_plan}.xes")
            last_planned_suffix = os.path.join(parent_path, generated_xes_path, f"problem{id_to_plan}.xes")
            log1 = pm4py.read_xes(original_suffix)
            log2 = pm4py.read_xes(last_planned_suffix)

        adjust_cost(id_to_plan, slack_instance, act_map)

        run_planner(id_to_plan)
        generate_xes_from_plan(decl_path=decl_loc, activity_mapping=activity_mapping,problem_id=id_to_plan, initial=False)
        # Load both logs
        replanned_suffix = os.path.join(parent_path, generated_xes_path, "optim", f"problem{id_to_plan}.xes")
        
        log3 = pm4py.read_xes(replanned_suffix)

        # Compare
        same_trace1 = log1[cols].equals(log3[cols])
        same_trace2 = log2[cols].equals(log3[cols])

        same_trace = (same_trace1 or same_trace2) 

        if same_trace:
            already_replanned[id_to_plan] += 1
            same_trace_count += 1
            print("Same trace generated again, count: ", same_trace_count)
        else:
            already_replanned[id_to_plan] = 0
            shutil.copy(src=replanned_suffix, dst=os.path.join(parent_path, generated_xes_path, f"problem{id_to_plan}.xes"))
            resulting_schedule = cp.run_schedule(os.path.join(parent_path, generated_xes_path), pn_loc, cost_model)
            print(resulting_schedule[0].BestObjectiveBound())
            if (best_ > resulting_schedule[0].BestObjectiveBound()):
                best_ = resulting_schedule[0].BestObjectiveBound()
                [shutil.copy(os.path.join(parent_path,generated_xes_path,p), os.path.join(parent_path,"best_config",p)) for p in os.listdir(os.path.join(parent_path,generated_xes_path)) if p.endswith(".xes")]

        
        #print(os.listdir(output_folder))
        currentIteration = time.time()
        print(id_to_plan, same_trace, currentIteration, currentIteration-currentStart, ((currentIteration-currentStart)<timeoutLimit))

    print(f"Best plan so far: {best_}")
