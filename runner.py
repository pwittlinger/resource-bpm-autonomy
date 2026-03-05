import sys
import time
import subprocess
import os
import random
import re
import json
os.environ['SHOW_PROGRESS_BAR'] = 'False'
os.environ['PM4PY_SHOW_PROGRESS_BAR'] = 'False'

import pm4py
import pandas as pd
import src.scheduler.cp_scheduler_fixed_resources as cp
import shutil
import tqdm
from functools import partialmethod


parent_path = os.path.abspath(os.getcwd())
output_folder = os.path.join(parent_path, "output", "pddl")


tqdm.__init__ = partialmethod(tqdm.__init__, disable=True)

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
                "-s", "WAStar",
                "-h", "blind"]

    #call_array = ["java", "-jar",
    #            os.path.join(parent_path, planner_path),
    #            "-o", os.path.join(parent_path, "grounded_domain.pddl"),
    #            "-f", os.path.join(output_folder, get_problem_path_from_id(problem_id)),
     #           "-s", "WAStar",
    #            "-h", "blind"]
    
    r = subprocess.call(call_array, stdout=output_file)
    #print(r)

def generate_all_initial_plans():
    nProbs = len(os.listdir(output_folder))

    for i in range(nProbs):
        print(f"Generating initial plan for problem{i+1}.pddl")
        run_planner(i+1)
        #if not (os.path.isfile(os.path.join(parent_path, generated_plan_path, f"problem{i+1}.txt"))):
        #    print(f"Generating initial plan for problem{i+1}.pddl")
        #    run_planner(i+1)

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


def adjust_cost(problem_id, gap_file, activity_map_object, initial, update_all = False):
    #[('ActivityA', 219), ('ActivityS', 17), ('ActivityM', 6)]

    gap = read_gap_file(os.path.join(parent_path, gap_file))

    gap_pairs = gap["tasks"]
    total_slack = gap["accumulated_slack"]

    with open(os.path.join(output_folder, f"problem{problem_id}.pddl")) as pf:
        content = pf.read()
    
    # I need to look for the cost allocations and replace them
    # (= (activity_cost a7 R0) 3) -> (= (activity_cost a7 R0) 10)

    for g in gap_pairs:
        act = g["task"]
        res = g["resource"]
        cost = g["predecessor_slack"]

        repl_act = activity_map_object[act]
        
        if (not update_all):
            old = fr"\(= \(activity_cost {repl_act} {res}\) ([\d]+)\)"
            old_cost = 0
            if find := re.search(old, content):
                old_cost = find.group(1)
            
            if initial:
                updated_cost = int(old_cost) + cost + int(total_slack)
            else:
                updated_cost = int(old_cost) + cost
            
            new = f"(= (activity_cost {repl_act} {res}) {updated_cost})"

            content = re.sub(old, new, content)

        
        # if (update_all):
        #old = fr"\(= \(activity_cost (.*) {res}\) ([\d]+)\)"
        #old_cost = 0
        #for m in re.finditer(old, content):
        #    old_act = m.group(1)
        #    old_cost = m.group(2)
        #    updated_cost = int(old_cost) + 700
        #    new = f"(= (activity_cost {old_act} {res}) {updated_cost})"
        #    content = re.sub(re.escape(m.group()), new, content)

        

        #updated_cost = int(old_cost) + cost + 700


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

def reset_space():
    # Move the current best to the pddl folder

    #[shutil.copy(os.path.join(parent_path,"output","initial",p),os.path.join(output_folder,p)) for p in os.listdir(os.path.join(parent_path,"output","initial")) if p.endswith(".pddl")]
    shutil.copy(os.path.join(parent_path, "best_config", "highest_slack_instance.json"), slack_instance)
    [shutil.copy(os.path.join(parent_path,"best_config", "pddl",p),os.path.join(output_folder,p)) for p in os.listdir(os.path.join(parent_path,"best_config", "pddl")) if p.endswith(".pddl")]

def reset_to_initial():
    [shutil.copy(os.path.join(parent_path,"output","initial",p),os.path.join(output_folder,p)) for p in os.listdir(os.path.join(parent_path,"output", "initial")) if p.endswith(".pddl")]
    #shutil.copy(os.path.join(parent_path, "best_config", "highest_slack_instance.json"), slack_instance)
    

def run_search(args, maxIterations, timeoutLimit):
    # Instantiate variables
    decl_loc, pn_loc, l, variable_values, var_sub_loc, cost_model = parse_input(args)
    pn_name = os.path.normpath(pn_loc).split(os.sep)[-1]
    
    activity_mapping = os.path.join(parent_path, "output", f"activityMapping_{pn_name}.txt")
    act_map = instantiate_mapping_file(activity_mapping=activity_mapping)

    subprocess.call(['java', '-jar', jar_path, "-d", decl_loc, "-p", pn_loc, "-o", l, "-a",variable_values,"-s", var_sub_loc, "-c",cost_model])

    [shutil.copy(os.path.join(output_folder,p),os.path.join(parent_path,"output", "initial",p)) for p in os.listdir(os.path.join(output_folder)) if p.endswith(".pddl")]

    
    generate_all_initial_plans()
    generate_all_xes_from_plan(decl_loc, activity_mapping)

    [shutil.copy(os.path.join(parent_path,generated_xes_path,p), os.path.join(parent_path,"best_config",p)) for p in os.listdir(os.path.join(parent_path,generated_xes_path)) if p.endswith(".xes")]
    [shutil.copy(os.path.join(parent_path,output_folder,p), os.path.join(parent_path,"best_config", "pddl",p)) for p in os.listdir(os.path.join(parent_path,output_folder)) if p.endswith(".pddl")]

    ################
    # Get initial schedule
    inrus = cp.run_schedule(os.path.join(parent_path, generated_xes_path), pn_loc, cost_model)

    initial_objective = inrus[0].BestObjectiveBound()
    last_objective = initial_objective

    # Instantiate the loop variables
    i = 0
    currentStart = time.time()
    currentIteration = 0
    same_trace = False
    same_trace_count = 0
    no_improvement_found = 0

    already_replanned = dict()
    best_ = initial_objective
    best_plan_iter = 0

    update_cost_strongly = False
    count_no_schedule_generated = 0
    found_objectives = []

    all_original_logs = []
    total_number_of_problems = len(os.listdir(output_folder))
        
    for j in range(total_number_of_problems):
        already_replanned[j+1] = 0
        all_original_logs.append(pm4py.read_xes(os.path.join(parent_path, generated_xes_path,"initial", f"problem{j+1}.xes")))
    
    max_replans_without_new_trace = int(total_number_of_problems*0.3)

    max_replans_without_new_trace = int(total_number_of_problems*0.3)
    while ((i < maxIterations) and ((currentIteration-currentStart)<timeoutLimit) and (last_objective <= initial_objective)):
    #while ((i < maxIterations) and ((currentIteration-currentStart)<timeoutLimit) and (no_improvement_found < max_replans_without_new_trace)):
        # Update iteration counter
        i = i+1

        # Select the instance to schedule
        gap = read_gap_file(os.path.join(parent_path, slack_instance))
        id_to_plan = int(gap["instance_id"].split("_")[1])

        if ((no_improvement_found > max_replans_without_new_trace) or (count_no_schedule_generated > max_replans_without_new_trace)):
            no_improvement_found = 0
            count_no_schedule_generated = 0
            update_cost_strongly = False

            for k in already_replanned.keys():
                already_replanned[k] = 0
            
            reset_space()

        if (already_replanned[id_to_plan] > 0):
            
            #print(f"{id_to_plan} has already been replanned more than two times without improvement")
            count = 0

            keys_with_zero = [k for k, v in already_replanned.items() if v == 0]
            number_current_replanned = total_number_of_problems-len(keys_with_zero)

            if (number_current_replanned >= max_replans_without_new_trace):
                

                for k in already_replanned.keys():
                    already_replanned[k] = 0
                
                keys_with_zero = [k for k, v in already_replanned.items() if v == 0]
                reset_space()

            id_to_plan = random.choice(keys_with_zero)
            

            
        last_planned_suffix = os.path.join(parent_path, generated_xes_path, f"problem{id_to_plan}.xes")
        log2 = pm4py.read_xes(last_planned_suffix)

        adjust_cost(id_to_plan, slack_instance, act_map, update_cost_strongly)
        shutil.copy(slack_instance, os.path.join(parent_path, "highest_slack_instance.json"))

        run_planner(id_to_plan)
        generate_xes_from_plan(decl_path=decl_loc, activity_mapping=activity_mapping,problem_id=id_to_plan, initial=False)
        # Load both logs
        replanned_suffix = os.path.join(parent_path, generated_xes_path, "optim", f"problem{id_to_plan}.xes")
        
        log3 = pm4py.read_xes(replanned_suffix)

        # Compare
        same_trace1 = all_original_logs[id_to_plan-1][cols].equals(log3[cols])
        same_trace2 = log2[cols].equals(log3[cols])

        same_trace = (same_trace1 or same_trace2) 

        if same_trace:
            already_replanned[id_to_plan] += 1
            count_no_schedule_generated += 1
            
            #print("Same trace generated again, count: ", same_trace_count, already_replanned[id_to_plan])
        else:
            count_no_schedule_generated = 0
            shutil.copy(src=replanned_suffix, dst=os.path.join(parent_path, generated_xes_path, f"problem{id_to_plan}.xes"))
            resulting_schedule = cp.run_schedule(os.path.join(parent_path, generated_xes_path), pn_loc, cost_model)
            
            #reset_to_initial()
        
            last_objective = resulting_schedule[0].BestObjectiveBound()
            found_objectives.append(last_objective)

            if (best_ > last_objective):
                no_improvement_found = 0
                
                best_plan_iter = i

                for k in already_replanned.keys():
                    already_replanned[k] = 0

                best_ = last_objective
                shutil.move(os.path.join(parent_path, "highest_slack_instance.json"), os.path.join(parent_path, "best_config", "highest_slack_instance.json"))
                [shutil.copy(os.path.join(parent_path,generated_xes_path,p), os.path.join(parent_path,"best_config",p)) for p in os.listdir(os.path.join(parent_path,generated_xes_path)) if p.endswith(".xes")]
                [shutil.copy(os.path.join(parent_path,output_folder,p), os.path.join(parent_path,"best_config", "pddl",p)) for p in os.listdir(os.path.join(parent_path,output_folder)) if p.endswith(".pddl")]
            else:
                #no_improvement_found += 1
                already_replanned[id_to_plan] += 1
                if (last_objective > initial_objective):
                    no_improvement_found +=1
                    shutil.copy(os.path.join(parent_path, "best_config", "highest_slack_instance.json"), slack_instance)
                else: 
                    no_improvement_found = 0
        #print(os.listdir(output_folder))
        currentIteration = time.time()
        print(id_to_plan, same_trace, currentIteration-currentStart)

    #print(f"Best plan so far: {best_} found after {best_plan_iter}")
    return [best_, best_plan_iter, found_objectives]




if __name__ == "__main__":
    print(sys.argv)
    # Stopping conditions for loop
    maxIterations = 50 # total number of iterations
    timeoutLimit = 300 # Maximum number of seconds spend

    b_, bi_ = run_search(sys.argv, maxIterations, timeoutLimit)

    print(f"Best Plan found on iteration {bi_}: {b_}")

