import sys
import time
import argparse
import subprocess
import os
import random

parent_path = os.path.abspath(os.getcwd())
output_folder = os.path.join(parent_path, "output", "pddl")


jar_path = "pddl_gen-1.0-SNAPSHOT-launcher.jar"
planner_path = "planner\enhsp.jar"
domain_path = "planner\domain_framed_autonomy_resource.pddl"
generated_plan_path = "generated_plans"
generated_xes_path = "generated_xes"
plan_parser = "ParsePlan.jar"
#parser = argparse.ArgumentParser()
#parser.add_argument("-o", "--Output", help="Show output message")


def get_problem_path_from_id(id_to_search):
    

    return f"problem{id_to_search}.pddl"
    all_problems = os.listdir(output_folder)
    # For all problems, check if the last part is equal to the ID
    for i in all_problems:
        current_problem_index = i.split("problem")[1]
        if current_problem_index == id_to_search:
            return i
    return False

def run_planner(problem_id):
    #call_array = ["java", "-jar",
    #            os.path.join(parent_path, planner_path),
    #            "-o", os.path.join(parent_path, domain_path),
    #            "-f", os.path.join(output_folder, get_problem_path_from_id(problem_id)),
    #            "-planner", "opt-blind",
    #            ">", os.path.join(parent_path, generated_plan_path, f"problem{problem_id}.txt"), "2>&1"]
    #subprocess.call(call_array, shell=True)
    output_file = open(os.path.join(parent_path, generated_plan_path, f"problem{problem_id}.txt"), "w")
    call_array = ["java", "-jar",
                os.path.join(parent_path, planner_path),
                "-o", os.path.join(parent_path, domain_path),
                "-f", os.path.join(output_folder, get_problem_path_from_id(problem_id)),
                "-planner", "opt-blind"]
    subprocess.call(call_array, stdout=output_file)

def generate_xes_from_plan(decl_path,activity_mapping, problem_id):

    generated_plan = os.path.join(parent_path, "generated_plans", f"problem{problem_id}.txt")
    xes_path = os.path.join(parent_path, "generated_xes", f"problem{problem_id}.xes")

    call_array = ["java", "-jar",
                  os.path.join(parent_path, plan_parser),
                  decl_path, activity_mapping, generated_plan, xes_path
                  ]
    subprocess.call(call_array)


#args = parser.parse_args()

#- d: Path to (MP-)DECLARE model (required)
#- p: Path to Petri-net model (optional)
#- l: Path to input XES file (containing the prefix)
#- c: Path to cost model file (if not present, will generate with standard cost function). Either .txt or .JSON
#- s: Path to variable substitution file (if not present will generate)
#- o: Path to output the PDDL files

#                "input_files\\declare\\a20g6_7_data_parsed.decl", 
#                "a40g17AND-del-5.xes", 
#                "input_files\\variable_values_multi_model.txt",
#                "input_files\\variable_substitutions_a20g6_7.decl.txt", 
#                "input_files\\cost_model-a20g6.txt",
#                "input_files\\petri_net\\a20g6.pnml"

if __name__ == "__main__":
    print(sys.argv)

   

    # Read in file paths to generate PDDL files
    decl_loc = os.path.join(parent_path,sys.argv[1])
    pn_loc = os.path.join(parent_path,sys.argv[6])
    l = os.path.join(parent_path,sys.argv[2])
    variable_values = os.path.join(parent_path,sys.argv[3])
    var_sub_loc = os.path.join(parent_path,sys.argv[4])
    cost_model = os.path.join(parent_path,sys.argv[5])

    pn_name = os.path.normpath(pn_loc).split(os.sep)[-1]

    activity_mapping = os.path.join(parent_path, "output", f"activityMapping_{pn_name}.txt")

    # Generate PDDL files
    subprocess.call(['java', '-jar', jar_path, "-d", decl_loc, "-p", pn_loc, "-o", l, "-a",variable_values,"-s", var_sub_loc, "-c",cost_model])
    
    # Creates files under the current path/output/pddl
    

    # Should start doing something here

    i = 0
    currentStart = time.time()
    currentIteration = 0

    #total number of iterations
    maxIterations = 10

    # Maximum number of seconds spend
    timeoutLimit = 25
    
    while ((i < 1000) and ((currentIteration-currentStart)<timeoutLimit)):
        # Update iteration counter
        i = i+1
        
        id_to_plan = random.randint(0,9)+1
        run_planner(id_to_plan)
        generate_xes_from_plan(decl_path=decl_loc, activity_mapping=activity_mapping,problem_id=id_to_plan)


        
        #print(os.listdir(output_folder))
        currentIteration = time.time()
        print(currentIteration, currentIteration-currentStart, ((currentIteration-currentStart)<timeoutLimit))

