import sys
import time
import subprocess
import os
import random
import re
import json

parent_path = os.path.abspath(os.getcwd())
output_folder = os.path.join(parent_path, "output", "pddl")


jar_path = "pddl_gen-1.0-SNAPSHOT-launcher.jar"
planner_path = "planner\enhsp.jar"
domain_path = "planner\domain_framed_autonomy_resource.pddl"
generated_plan_path = "generated_plans"
generated_xes_path = "generated_xes"
plan_parser = "ParsePlan.jar"
slack_instance = "input_files/slack_analysis_output/highest_slack_instance.json"


def get_problem_path_from_id(id_to_search):
    return f"problem{id_to_search}.pddl"

def run_planner(problem_id):
    output_file = open(os.path.join(parent_path, generated_plan_path, f"problem{problem_id}.txt"), "w")
    call_array = ["java", "-jar",
                os.path.join(parent_path, planner_path),
                "-o", os.path.join(parent_path, domain_path),
                "-f", os.path.join(output_folder, get_problem_path_from_id(problem_id)),
                "-planner", "opt-blind"]
    
    subprocess.call(call_array, stdout=output_file)

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
            generate_xes_from_plan(decl_path=decl_path, activity_mapping=activity_mapping, problem_id = i+1)


def generate_xes_from_plan(decl_path,activity_mapping, problem_id):
    """Converts the plan (.txt) into an actual XES file corresponding to the generated suffix.
    """
    generated_plan = os.path.join(parent_path, "generated_plans", f"problem{problem_id}.txt")
    xes_path = os.path.join(parent_path, "generated_xes", f"problem{problem_id}.xes")

    call_array = ["java", "-jar",
                  os.path.join(parent_path, plan_parser),
                  decl_path, activity_mapping, generated_plan, xes_path
                  ]
    subprocess.call(call_array)


def adjust_cost(problem_id, gap_file, activity_map_object):
    #[('ActivityA', 219), ('ActivityS', 17), ('ActivityM', 6)]

    gap = read_gap_file(os.path.join(parent_path, gap_file))

    gap_pairs = gap["tasks"]

    with open(os.path.join(output_folder, f"problem{problem_id}.pddl")) as pf:
        content = pf.read()
    
    # I need to look for the cost allocations and replace them
    # (= (activity_cost a7 R0) 3) -> (= (activity_cost a7 R0) 10)

    # I

    for g in gap_pairs:
        act = g["task"]
        res = g["resource"]
        cost = g["predecessor_slack"]

        repl_act = activity_map_object[act]
        old = f"\(= \(activity_cost {repl_act} {res}\) ([\d]+)\)"
        #find = re.search(old, content)
        old_cost = 0

        if find := re.search(old, content):
            old_cost = find.group(1)

        updated_cost = int(old_cost) + cost + 700
        
        new = f"(= (activity_cost {repl_act} {res}) {updated_cost})"

        content = re.sub(old, new, content)

    with open(os.path.join(output_folder, f"problem{problem_id}.pddl"), "w") as pf:
        pf.write(content)

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
    maxIterations = 5 # total number of iterations
    timeoutLimit = 35 # Maximum number of seconds spend

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

    # Instantiate the loop variables
    i = 0
    currentStart = time.time()
    currentIteration = 0

    while ((i < maxIterations) and ((currentIteration-currentStart)<timeoutLimit)):
        # Update iteration counter
        i = i+1
        
        # At this step, I need to get the correct ID to replan
        # And I need to update the cost model of the plan.
        id_to_plan = random.randint(0,9)+1

        adjust_cost(id_to_plan, slack_instance, act_map)

        run_planner(id_to_plan)
        generate_xes_from_plan(decl_path=decl_loc, activity_mapping=activity_mapping,problem_id=id_to_plan)

        
        #print(os.listdir(output_folder))
        currentIteration = time.time()
        print(id_to_plan, currentIteration, currentIteration-currentStart, ((currentIteration-currentStart)<timeoutLimit))

