import sys
import time
import subprocess
import os
import random
import re
import json
import math
import multiprocessing
import queue
import shlex
os.environ['SHOW_PROGRESS_BAR'] = 'False'
os.environ['PM4PY_SHOW_PROGRESS_BAR'] = 'False'

import pm4py
import pandas as pd
import src.scheduler.cp_scheduler_fixed_resources as cp
import src.scheduler.cp_scheduler as cpnf
import shutil
import tqdm
import json
from functools import partialmethod
import cProfile
import pstats
import io

from src.scheduler.plotly_visualizer import (
    save_schedule_plotly_png,
    visualize_schedule_plotly,
)
from src.scheduler.schedule_data import ScheduleData


parent_path = os.path.abspath(os.getcwd())
output_folder = os.path.join(parent_path, "output", "pddl")



tqdm.__init__ = partialmethod(tqdm.__init__, disable=True)

shadow_cost = os.path.join(parent_path, "input_files","slack_analysis_output", "resource_shadow_costs.json")
#input_files/slack_analysis_output

jar_path = "pddl_gen-1.0-SNAPSHOT-launcher.jar"
planner_path = os.path.join("planner", "enhsp.jar")#"planner\enhsp.jar"
domain_path = os.path.join("planner", "domain_framed_autonomy_resource.pddl")#"planner\domain_framed_autonomy_resource.pddl"
generated_plan_path = "generated_plans"
generated_xes_path = "generated_xes"
plan_parser = "ParsePlan.jar"
slack_instance = os.path.join("input_files","slack_analysis_output","highest_slack_instance.json")#"input_files/slack_analysis_output/highest_slack_instance.json"
grounder_jar = "enhsp-grounded-plan.jar"

cols = ["concept:name", "org:resource", "case:concept:name"]


class JavaExecutionError(RuntimeError):
    """Raised when one of the Java tools used by the experiment fails."""


def build_java_command(jar_file, *arguments, jvm_options=None):
    """Build a Java command with JVM options in their required position."""
    jar_file = (
        jar_file
        if os.path.isabs(jar_file)
        else os.path.join(parent_path, jar_file)
    )
    return [
        "java",
        *(jvm_options or []),
        "-jar",
        jar_file,
        *(str(argument) for argument in arguments),
    ]


def run_java_command(command, description, stdout_path=None):
    """Run a Java tool and turn a non-zero exit into an actionable error."""
    if stdout_path is None:
        result = subprocess.run(
            command,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            text=True,
        )
    else:
        os.makedirs(os.path.dirname(stdout_path), exist_ok=True)
        with open(stdout_path, "w") as output_file:
            result = subprocess.run(
                command,
                stdout=output_file,
                stderr=subprocess.PIPE,
                text=True,
            )

    if result.returncode != 0:
        details = (result.stderr or "").strip()
        if not details and stdout_path is None:
            details = (result.stdout or "").strip()
        if not details:
            details = "The Java process did not provide an error message."
        raise JavaExecutionError(
            f"{description} failed with exit code {result.returncode}.\n"
            f"Command: {shlex.join(command)}\n"
            f"Java output:\n{details}"
        )
    return result


def require_file(path, description):
    if not os.path.isfile(path):
        raise JavaExecutionError(
            f"{description} did not create the expected file: {path}"
        )
    return path


def validate_run_inputs(args):
    """Fail before cleanup when Java or an experiment input is unavailable."""
    if shutil.which("java") is None:
        raise JavaExecutionError("Java is not available on PATH.")

    decl_loc, pn_loc, log_path, variable_values, var_sub_loc, cost_model = (
        parse_input(args)
    )
    required_files = {
        "PDDL generator": os.path.join(parent_path, jar_path),
        "planner": os.path.join(parent_path, planner_path),
        "plan parser": os.path.join(parent_path, plan_parser),
        "grounder": os.path.join(parent_path, grounder_jar),
        "planner domain": os.path.join(parent_path, domain_path),
        "DECLARE model": decl_loc,
        "event log": log_path,
        "variable assignments": variable_values,
        "variable substitutions": var_sub_loc,
        "resource assignments": cost_model,
        "Petri net": pn_loc,
    }
    missing = [
        f"- {description}: {path}"
        for description, path in required_files.items()
        if not os.path.isfile(path)
    ]
    if missing:
        raise FileNotFoundError(
            "Experiment prerequisites are missing:\n" + "\n".join(missing)
        )


def save_schedule_artifacts(
    schedule_data,
    output_directory,
    x_axis_max=None,
):
    """Save one evaluation schedule as both JSON and PNG."""
    if not isinstance(schedule_data, ScheduleData):
        raise TypeError("schedule_data must be a ScheduleData object.")
    if not schedule_data.name:
        raise ValueError("schedule_data must have a name.")

    json_path = schedule_data.save(
        os.path.join(output_directory, f"{schedule_data.name}.json")
    )
    figure = visualize_schedule_plotly(
        schedule_data,
        show=False,
        x_axis_max=x_axis_max,
    )
    png_path = save_schedule_plotly_png(
        figure,
        output_directory,
        f"{schedule_data.name}.png",
    )
    return json_path, png_path


def get_problem_path_from_id(id_to_search):
    return f"problem{id_to_search}.pddl"

def run_planner(problem_id, groundedVersion = True):
    if groundedVersion:
        domainPath = os.path.join(parent_path, "grounded-problems", f"problem{problem_id}_grounded.pddl")
    else:
        domainPath = os.path.join(parent_path, domain_path)

    output_path = os.path.join(
        parent_path, generated_plan_path, f"problem{problem_id}.txt"
    )
    call_array = build_java_command(
        planner_path,
        "-o", domainPath,
        "-f", os.path.join(output_folder, get_problem_path_from_id(problem_id)),
        "-s", "WAStar",
        "-h", "blind",
        "-dap",
    )
    run_java_command(
        call_array,
        f"Planning problem {problem_id}",
        stdout_path=output_path,
    )
    require_file(output_path, f"Planner for problem {problem_id}")

def generate_single_grounding(problem_id):
    grounder_output_path = os.path.join(
        parent_path, generated_plan_path, f"problem{problem_id}.txt"
    )
    grounded_output_path = os.path.join(
        output_folder, f"problem{problem_id}_grounded.pddl"
    )
    call_array = build_java_command(
        grounder_jar,
        os.path.join(parent_path, domain_path),
        os.path.join(output_folder, get_problem_path_from_id(problem_id)),
        jvm_options=["-Xmx16G"],
    )
    run_java_command(
        call_array,
        f"Grounding problem {problem_id}",
        stdout_path=grounder_output_path,
    )
    require_file(grounded_output_path, f"Grounder for problem {problem_id}")
    if os.path.exists(os.path.join("grounded-problems", f"problem{problem_id}_grounded.pddl")):
        os.remove(os.path.join("grounded-problems", f"problem{problem_id}_grounded.pddl"))
    shutil.move(grounded_output_path, "grounded-problems")
    shutil.copy(os.path.join("grounded-problems",f"problem{problem_id}_grounded.pddl"),os.path.join("grounded-problems","initial",f"problem{problem_id}_grounded.pddl"))


def generate_groundings():
    nProbs = len(os.listdir(output_folder))

    for i in range(nProbs):
        if not os.path.exists(os.path.join(output_folder,get_problem_path_from_id(i+1))):
            continue
        print(f"Generating initial grounding for problem{i+1}.pddl")
        generate_single_grounding(i+1)

        [shutil.copy(os.path.join(output_folder,p),os.path.join(parent_path, "output", "initial",p)) for p in os.listdir(os.path.join(output_folder)) if p.endswith(".pddl")]


def generate_all_initial_plans():
    nProbs = len(os.listdir(output_folder))

    for i in range(nProbs):
        print(f"Generating initial plan for problem{i+1}.pddl")
        run_planner(i+1)
        #[shutil.copy(os.path.join(output_folder,p),os.path.join(parent_path, "output", "initial",p)) for p in os.listdir(os.path.join(output_folder)) if p.endswith(".pddl")]

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

    call_array = build_java_command(
        plan_parser,
        decl_path,
        activity_mapping,
        generated_plan,
        xes_path,
    )
    run_java_command(
        call_array,
        f"Converting the plan for problem {problem_id} to XES",
    )
    require_file(xes_path, f"Plan parser for problem {problem_id}")

    if initial:
        shutil.copy(xes_path, os.path.join(parent_path, "generated_xes", f"problem{problem_id}.xes"))


def adjust_cost(problem_id:int, gap_file:str, activity_map_object:dict, global_cost_model):
    #[('ActivityA', 219), ('ActivityS', 17), ('ActivityM', 6)]

    gap = read_gap_file(os.path.join(parent_path, gap_file))

    gap_pairs = gap["tasks"]
    total_slack = gap["accumulated_slack"]

    #with open(os.path.join(output_folder, f"problem{problem_id}.pddl")) as pf:
    #    content = pf.read()
    with open(os.path.join(parent_path,"grounded-problems", f"problem{problem_id}_grounded.pddl")) as pf:
        content = pf.read()
    
    # I need to look for the cost allocations and replace them
    # (= (activity_cost a7 R0) 3) -> (= (activity_cost a7 R0) 10)

    for g in gap_pairs:
        act = g["task"]
        res = g["resource"]
        cost = g["predecessor_slack"]

        next_cheapest_alternative = get_next_cheapest_alternative(global_cost_model, act, res)
        repl_act = activity_map_object[act]

        firstIndex = content.find(f"add_action_{repl_act}_{res}")
        actionCostMatch = re.search("\\d+\\.\\d+", content[firstIndex:])

        cost = min(cost, (next_cheapest_alternative-float(actionCostMatch.group()))+1)

        
        

        content = change(content, repl_act, res, cost, True)


    

    with open(os.path.join(parent_path, "grounded-problems", f"problem{problem_id}_grounded.pddl"), "w") as pf:
        pf.write(content)
        #pf.write(new_content)

def adjust_shadow_cost(problem_id:int, act_map:dict, instance_id:int):
    reset_to_initial()

    data = read_gap_file(shadow_cost)

    with open(os.path.join(parent_path,"grounded-problems", f"problem{problem_id}_grounded.pddl")) as pf:
        content = pf.read()

    up = data["resources"]

    for res in up:

        update_factor = up[res]["contention_index"]

        #old = fr"\(= \(activity_cost (.*) {res}\) ([\d]+)\)"

        for task_t in up[res]['instances'][instance_id]["tasks"]:
            mapped_task = act_map[task_t]
            old = fr"add_action_({mapped_task})_{res}"
            old_cost = 0
            #updated_cost = up[res]["penalty_rate"]
            update_factor = up[res]['instances'][instance_id]["tasks"][task_t]["task_specific_tax"]

            content = change(content, mapped_task, res, update_factor, False)


        #old = fr"add_action_(.*)_{res}"
        #old_cost = 0
        ##updated_cost = up[res]["penalty_rate"]
        #update_factor = up[res]["contention_index"]
        #for m in re.finditer(old, content):
        #    old_act = m.group(1)
            #old_cost = m.group(2)

        #    content = change(content, old_act, res, update_factor, False)


            #updated_cost = int(old_cost) + updated_cost
            #updated_cost = int(old_cost) * update_factor
            #new = f"(= (activity_cost {old_act} {res}) {updated_cost})"
            #content = re.sub(re.escape(m.group()), new, content)

        

        #updated_cost = int(old_cost) + cost + 700
    with open(os.path.join(parent_path, "grounded-problems", f"problem{problem_id}_grounded.pddl"), "w") as pf:
        pf.write(content)
    return True
    

def read_gap_file(gap_file):
    with open(gap_file) as f:
        data = json.load(f)
    return data



def get_next_cheapest_alternative(data: list[dict], activity: str, resource: str) -> int | None:
    """
    Given a task-resource assignment list, an activity name, and a resource ID,
    returns the duration of the next cheapest alternative resource for that activity
    (i.e. the cheapest resource that is NOT the given one).

    Returns None if no alternative exists.
    """
    alternatives = [
        entry for entry in data
        if entry["task"] == activity and entry["resource"] != resource
    ]

    if not alternatives:
        return float("inf")

    next_cheapest = min(alternatives, key=lambda x: x["duration"])
    return next_cheapest["duration"]


def instantiate_mapping_file(activity_mapping):

    actmap = {}
    with open(activity_mapping) as mf:
        for line in mf:
            val = line.replace("\n", "").split(":")
            actmap[val[0]] = val[1]

    return actmap

def cleanRepos():
    # Generated Plans
    # Generated XES
    ## initial
    ## optim
    # Grounded Problems
    ## best
    ## initial
    genreated_xes_remove = [x for x in os.listdir(generated_xes_path) if x.endswith(".xes")]
    genreated_xes_remove_initial = [x for x in os.listdir(os.path.join(generated_xes_path, "initial")) if x.endswith(".xes")]
    genreated_xes_remove_optim = [x for x in os.listdir(os.path.join(generated_xes_path, "optim")) if x.endswith(".xes")]

    [os.remove(os.path.join(generated_xes_path, x)) for x in genreated_xes_remove]
    [os.remove(os.path.join(generated_xes_path, "initial", x)) for x in genreated_xes_remove_initial]
    [os.remove(os.path.join(generated_xes_path, "optim", x)) for x in genreated_xes_remove_optim]

    plans_remove = [x for x in os.listdir(generated_plan_path) if x.endswith(".txt")]

    [os.remove(os.path.join(generated_plan_path, x)) for x in plans_remove]

    best_config_remove = [x for x in os.listdir(os.path.join(parent_path, "best_config")) if x.endswith(".xes")]
    best_config_remove_pddl = [x for x in os.listdir(os.path.join(parent_path, "best_config", "pddl")) if x.endswith(".pddl")]

    [os.remove(os.path.join(parent_path, "best_config", x)) for x in best_config_remove]
    [os.remove(os.path.join(parent_path, "best_config", "pddl", x)) for x in best_config_remove_pddl]

    grounded_remove = [x for x in os.listdir(os.path.join(parent_path, "grounded-problems")) if x.endswith(".pddl")]
    grounded_remove_best = [x for x in os.listdir(os.path.join(parent_path, "grounded-problems", "best")) if x.endswith(".pddl")]
    grounded_remove_initial = [x for x in os.listdir(os.path.join(parent_path, "grounded-problems", "initial")) if x.endswith(".pddl")]

    [os.remove(os.path.join(parent_path, "grounded-problems", x)) for x in grounded_remove]
    [os.remove(os.path.join(parent_path, "grounded-problems", "best", x)) for x in grounded_remove_best]
    [os.remove(os.path.join(parent_path, "grounded-problems","initial", x)) for x in grounded_remove_initial]


    initial_remove = [x for x in os.listdir(os.path.join(parent_path, "output", "initial")) if x.endswith(".pddl")]
    pddl_remove = [x for x in os.listdir(os.path.join(parent_path, "output", "pddl")) if x.endswith(".pddl")]
    
    [os.remove(os.path.join(parent_path, "output", "initial", x)) for x in initial_remove]
    [os.remove(os.path.join(parent_path, "output", "pddl", x)) for x in pddl_remove]

    
def parse_input(args):
    """Takes the array of arguments and returns paths.
    """

    decl_loc = os.path.join(parent_path,args[1])
    pn_loc = os.path.join(parent_path,args[6])
    l = os.path.join(parent_path,args[2])
    variable_values = os.path.join(parent_path,args[3])
    var_sub_loc = os.path.join(parent_path,args[4])
    cost_model = os.path.join(parent_path,args[5])

    return decl_loc, pn_loc, l, variable_values, var_sub_loc, cost_model

def reset_space():
    """Reset the current plan to the best value found so far.
    """
    # Move the current best to the pddl folder

    #[shutil.copy(os.path.join(parent_path,"output","initial",p),os.path.join(output_folder,p)) for p in os.listdir(os.path.join(parent_path,"output","initial")) if p.endswith(".pddl")]
    shutil.copy(os.path.join(parent_path, "best_config", "highest_slack_instance.json"), slack_instance)
    #[shutil.copy(os.path.join(parent_path,"best_config", "pddl",p),os.path.join(output_folder,p)) for p in os.listdir(os.path.join(parent_path,"best_config", "pddl")) if p.endswith(".pddl")]
    [shutil.copy(os.path.join(parent_path,"grounded-problems","best",p),os.path.join(parent_path,"grounded-problems",p)) for p in os.listdir(os.path.join(parent_path,"grounded-problems","best")) if p.endswith(".pddl")]
    shutil.copy(os.path.join(parent_path, "best_config", "resource_shadow_costs.json"), shadow_cost)

def reset_to_initial():
    """This effectively resets the costs of the PDDL instances.
    Move the first generated PDDL files to the output folder again."""
    #[shutil.copy(os.path.join(parent_path,"output","initial",p),os.path.join(output_folder,p)) for p in os.listdir(os.path.join(parent_path,"output", "initial")) if p.endswith(".pddl")]
    [shutil.copy(os.path.join(parent_path,"grounded-problems","initial",p),os.path.join(parent_path, "grounded-problems",p)) for p in os.listdir(os.path.join(parent_path,"grounded-problems","initial")) if p.endswith(".pddl")]
    
    #shutil.copy(os.path.join(parent_path, "best_config", "highest_slack_instance.json"), slack_instance)
    

def run_search(
    args,
    maxIterations: int,
    timeoutLimit: int,
    cost_update_strategy: str,
    schedule_output_dir=None,
):
    """
    Run the search and optionally save all evaluation schedules.
    """

    validate_run_inputs(args)
    cleanRepos()
    # Instantiate variables
    decl_loc, pn_loc, l, variable_values, var_sub_loc, cost_model = parse_input(args)
    pn_name = os.path.normpath(pn_loc).split(os.sep)[-1]
    
    activity_mapping = os.path.join(
        parent_path, "output", f"activityMapping_{pn_name}.txt"
    )

   
    # initialize global cost model (resource assignment file)
    with open(cost_model) as f:
        all_assignments = json.load(f)
    available_resources = list(dict.fromkeys(
        str(assignment["resource"])
        for assignment in all_assignments
    ))

    #subprocess.call(['java', '-jar', jar_path, "-d", decl_loc, "-p", pn_loc, "-o", l, "-a",variable_values,"-s", var_sub_loc, "-c",cost_model])
    pddl_generator_command = build_java_command(
        jar_path,
        "-d", decl_loc,
        "-p", pn_loc,
        "-o", l,
        "-a", variable_values,
        "-s", var_sub_loc,
        "-c", cost_model,
    )
    run_java_command(
        pddl_generator_command,
        "Generating PDDL problems",
    )
    generated_problems = [
        file_name
        for file_name in os.listdir(output_folder)
        if file_name.startswith("problem") and file_name.endswith(".pddl")
    ]
    if not generated_problems:
        raise JavaExecutionError(
            f"The PDDL generator succeeded but created no problem files in "
            f"{output_folder}."
        )
    require_file(activity_mapping, "PDDL generator activity mapping")
    act_map = instantiate_mapping_file(activity_mapping=activity_mapping)

    # Move initially generated PDDL files to initial folder.
    [shutil.copy(os.path.join(output_folder,p),os.path.join(parent_path,"output", "initial",p)) for p in os.listdir(os.path.join(output_folder)) if p.endswith(".pddl")]

    # I need
    # - PN name
    # - Number Resources
    # - XES
    cost_name = os.path.basename(cost_model).removesuffix(".json")
    log_name = os.path.basename(l).removesuffix(".xes")
    
    if not os.path.exists(os.path.join(parent_path, "save-grounded", log_name+cost_name)):
        generate_groundings()
        os.makedirs(os.path.join(parent_path, "save-grounded", log_name+cost_name))
        [shutil.copy(os.path.join(parent_path, "grounded-problems",p), os.path.join(parent_path, "save-grounded", log_name+cost_name, p)) for p in os.listdir(os.path.join(parent_path, "grounded-problems")) if p.endswith(".pddl")]
        
    else:
        [shutil.copy(os.path.join(parent_path, "save-grounded", log_name+cost_name,p),os.path.join(parent_path, "grounded-problems",p)) for p in os.listdir(os.path.join(parent_path, "save-grounded", log_name+cost_name)) if p.endswith(".pddl")]
   
    # When generating the Plans with the Propositionalized version, we get different results (same plan COST though)
    # This causes the first iteration to already find an optimal plan?
    generate_all_initial_plans()
    generate_all_xes_from_plan(decl_loc, activity_mapping)

    [shutil.copy(os.path.join(parent_path,generated_xes_path,p), os.path.join(parent_path,"best_config",p)) for p in os.listdir(os.path.join(parent_path,generated_xes_path)) if p.endswith(".xes")]
    [shutil.copy(os.path.join(parent_path,output_folder,p), os.path.join(parent_path,"best_config", "pddl",p)) for p in os.listdir(os.path.join(parent_path,output_folder)) if p.endswith(".pddl")]

    ################
    # Get initial schedule
    inrus = cp.run_schedule(os.path.join(parent_path, generated_xes_path), pn_loc, cost_model)

    #initial_objective = inrus[0].BestObjectiveBound()
    initial_objective = inrus[0].ObjectiveValue()
    initial_schedule_data = ScheduleData.from_solver(
        inrus[0],
        inrus[1],
        name="initial_schedule",
        resources=available_resources,
    )
    # Use the initialized schedule as the shared comparison horizon for every
    # schedule visualization produced by this experiment.
    comparison_x_axis_max = initial_schedule_data.max_finish
    best_schedule_data = ScheduleData.from_dict(
        initial_schedule_data.to_dict()
    )
    best_schedule_data.name = "best_schedule"
    if schedule_output_dir is not None:
        save_schedule_artifacts(
            initial_schedule_data,
            schedule_output_dir,
            x_axis_max=comparison_x_axis_max,
        )
    last_objective = initial_objective
    shutil.copy(shadow_cost, os.path.join(parent_path, "best_config"))
    shutil.copy(slack_instance, os.path.join(parent_path, "best_config"))

    ##################
    initial_benchmark = cpnf.run_scheduler(os.path.join(parent_path, generated_xes_path), pn_loc, cost_model, timeoutLimit)
    bench1 = initial_benchmark[0].ObjectiveValue()
    initial_benchmark_tasks = cpnf.prepare_all_tasks(
        initial_benchmark[0],
        initial_benchmark[1],
    )
    initial_benchmark_schedule_data = ScheduleData.from_solver(
        initial_benchmark[0],
        initial_benchmark_tasks,
        name="initial_benchmark_schedule",
        resources=available_resources,
    )
    if schedule_output_dir is not None:
        save_schedule_artifacts(
            initial_benchmark_schedule_data,
            schedule_output_dir,
            x_axis_max=comparison_x_axis_max,
        )

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

    # update_cost_strongly sets the flag that the total slack will be added on top of the current slack for all resource allocs
    count_no_schedule_generated = 0
    found_objectives = []
    
    found_objectives.append(initial_objective)

    all_original_logs = []
    total_number_of_problems = len(os.listdir(output_folder))
        
    for j in range(total_number_of_problems):
        already_replanned[j+1] = 0
        all_original_logs.append(pm4py.read_xes(os.path.join(parent_path, generated_xes_path,"initial", f"problem{j+1}.xes")))
    
    keys_with_zero = [k for k, v in already_replanned.items() if v == 0]

    
    if (cost_update_strategy == "contention"):
        max_replans_without_new_trace = int(total_number_of_problems)
    elif (cost_update_strategy == "slack"):
        max_replans_without_new_trace = int(total_number_of_problems*0.3)

    #max_replans_without_new_trace = int(total_number_of_problems*0.3)
    while ((i < maxIterations) and ((currentIteration-currentStart)<timeoutLimit)):
    #while ((i < maxIterations) and ((currentIteration-currentStart)<timeoutLimit) and (no_improvement_found < max_replans_without_new_trace)):
        # Update iteration counter
        i = i+1

        # Select the instance to schedule
        gap = read_gap_file(os.path.join(parent_path, slack_instance))
        id_to_plan = int(gap["instance_id"].split("_")[1])


        if ((no_improvement_found > max_replans_without_new_trace) or (count_no_schedule_generated > max_replans_without_new_trace)):
            i = maxIterations
            break
            no_improvement_found = 0
            count_no_schedule_generated = 0
            #update_cost_strongly = False

            for k in already_replanned.keys():
                already_replanned[k] = 0
            
            reset_space()
            #reset_to_initial()

        # Check if the current id had already been planned.
        if (already_replanned[id_to_plan] > 0):
            
            keys_with_zero = [k for k, v in already_replanned.items() if v == 0]
            number_current_replanned = total_number_of_problems-len(keys_with_zero)

            if (number_current_replanned >= max_replans_without_new_trace):
                

                for k in already_replanned.keys():
                    already_replanned[k] = 0
                
                keys_with_zero = [k for k, v in already_replanned.items() if v == 0]
                reset_space()

            id_to_plan = random.choice(keys_with_zero)
            


        
        if cost_update_strategy == "contention":
            adjust_shadow_cost(id_to_plan, act_map, gap["instance_id"])
        elif cost_update_strategy == "slack":
            adjust_cost(id_to_plan, slack_instance, act_map, all_assignments)

        # intermediately saves the slack instance file
        shutil.copy(slack_instance, os.path.join(parent_path, "highest_slack_instance.json"))
        shutil.copy(shadow_cost, os.path.join(parent_path, "resource_shadow_costs.json"))

        run_planner(id_to_plan)
        generate_xes_from_plan(decl_path=decl_loc, activity_mapping=activity_mapping,problem_id=id_to_plan, initial=False)

        # Load both logs
        last_planned_suffix = os.path.join(parent_path, generated_xes_path, f"problem{id_to_plan}.xes")
        log2 = pm4py.read_xes(last_planned_suffix)

        replanned_suffix = os.path.join(parent_path, generated_xes_path, "optim", f"problem{id_to_plan}.xes")
        log3 = pm4py.read_xes(replanned_suffix)

        # Compare
        same_trace1 = all_original_logs[id_to_plan-1][cols].equals(log3[cols])
        same_trace2 = log2[cols].equals(log3[cols])

        same_trace = (same_trace1 or same_trace2) 

        if same_trace:
            already_replanned[id_to_plan] += 1
            count_no_schedule_generated += 1
    
        else:
            count_no_schedule_generated = 0
            shutil.copy(src=replanned_suffix, dst=os.path.join(parent_path, generated_xes_path, f"problem{id_to_plan}.xes"))
            
            #resulting_schedule = cp.run_schedule(os.path.join(parent_path, generated_xes_path), pn_loc, cost_model)
            #last_objective = resulting_schedule[0].ObjectiveValue()

            resilient_result = resilient_solve(
                os.path.join(parent_path, generated_xes_path),
                pn_loc,
                cost_model,
                timeoutLimit,
                include_schedule_data=schedule_output_dir is not None,
            )
            
            if resilient_result["status"] == "success":
                last_objective = resilient_result["solution"]
            else:
                continue
        
            # get objective of plan
            
            found_objectives.append(last_objective)

            if (best_ > last_objective): 
                no_improvement_found = 0
                
                best_plan_iter = i

                for k in already_replanned.keys():
                    already_replanned[k] = 0

                best_ = last_objective
                if schedule_output_dir is not None:
                    best_schedule_data = ScheduleData.from_dict(
                        resilient_result["schedule_data"]
                    )
                    best_schedule_data.name = "best_schedule"
                
                shutil.move(os.path.join(parent_path, "resource_shadow_costs.json"), os.path.join(parent_path, "best_config", "resource_shadow_costs.json"))
                shutil.move(os.path.join(parent_path, "highest_slack_instance.json"), os.path.join(parent_path, "best_config", "highest_slack_instance.json"))
                [shutil.copy(os.path.join(parent_path,generated_xes_path,p), os.path.join(parent_path,"best_config",p)) for p in os.listdir(os.path.join(parent_path,generated_xes_path)) if p.endswith(".xes")]
                [shutil.copy(os.path.join(output_folder,p), os.path.join(parent_path,"best_config", "pddl",p)) for p in os.listdir(os.path.join(output_folder)) if p.endswith(".pddl")]
                [shutil.copy(os.path.join(parent_path, "grounded-problems",p), os.path.join(parent_path,"grounded-problems","best",p)) for p in os.listdir(os.path.join(parent_path, "grounded-problems")) if p.endswith(".pddl")]

                
            else:
                no_improvement_found += 1
                already_replanned[id_to_plan] += 1


                if (last_objective > initial_objective):
                    # Breaks the loop
                    #i = maxIterations
                    #no_improvement_found +=1
                    #reset_space()
                    #if cost_update_strategy == "contention":
                    #    cost_update_strategy = "slack"

                    reset_to_initial()
                    #shutil.copy(os.path.join(parent_path, "best_config", "highest_slack_instance.json"), slack_instance)

        currentIteration = time.time()
        print(id_to_plan, same_trace, currentIteration-currentStart)

        #####
    # Running the scheduler with variable assignments for the best known set resource assignment
    best_benchmark = cpnf.run_scheduler(os.path.join(parent_path,"best_config"), pn_loc, cost_model, timeoutLimit)

    bench2 = best_benchmark[0].ObjectiveValue()
    if schedule_output_dir is not None:
        save_schedule_artifacts(
            best_schedule_data,
            schedule_output_dir,
            x_axis_max=comparison_x_axis_max,
        )
        best_benchmark_tasks = cpnf.prepare_all_tasks(
            best_benchmark[0],
            best_benchmark[1],
        )
        best_benchmark_schedule_data = ScheduleData.from_solver(
            best_benchmark[0],
            best_benchmark_tasks,
            name="best_benchmark_schedule",
            resources=available_resources,
        )
        save_schedule_artifacts(
            best_benchmark_schedule_data,
            schedule_output_dir,
            x_axis_max=comparison_x_axis_max,
        )
    
    return [best_, best_plan_iter, found_objectives, bench1, bench2]



def change(pddlContent:str, activity:str, resource:str, cost:float, additive:bool):
    firstIndex = pddlContent.find(f"add_action_{activity}_{resource}")
    actionCostMatch = re.search("\\d+\\.\\d+", pddlContent[firstIndex:])
    
    firstPart = pddlContent[:actionCostMatch.start()+firstIndex]
    secondPart = pddlContent[firstIndex+actionCostMatch.start()+len(actionCostMatch.group()):]

    newCost = float(actionCostMatch.group())

    if additive:
        newCost = newCost + cost
    else:
        newCost = newCost * (cost)


    return firstPart + str(newCost) + secondPart


def resilient_solve(
    full_xes_path,
    petri_net_location,
    resource_cost_assignments,
    timeout,
    include_schedule_data=False,
):
    #result_queue = multiprocessing.Queue()
   
    try:
        #result_queue = multiprocessing.Manager().Queue()
        result_queue = multiprocessing.Queue()
        #result_queue = manager.Queue()

        process = multiprocessing.Process(
            target=solver_worker,
            args=(
                result_queue,
                full_xes_path,
                petri_net_location,
                resource_cost_assignments,
                include_schedule_data,
            ),
        )
        #cp.run_schedule(full_xes_path, petri_net_location, resource_cost_assignments)

        process.start()
        try:
            result = result_queue.get(timeout=timeout)
        except queue.Empty:
            if process.is_alive():
                process.terminate()
                process.join()
                return fallback_result(reason="timeout")
            return fallback_result(reason="no_result")

        process.join()

        if process.exitcode != 0:
            print("Error in model solving")
            return fallback_result(reason="crash")

        return result
    
    finally:
        result_queue.close()
        result_queue.join_thread()
        if process.is_alive():
            process.terminate()
        process.join()

def solver_worker(
    result_queue,
    full_xes_path,
    petri_net_location,
    resource_cost_assignments,
    include_schedule_data=False,
):
    result = cp.run_schedule(full_xes_path, petri_net_location, resource_cost_assignments)

    if result is None:
        result_queue.put({"status":"error"})
    else:
        response = {
            "status": "success",
            "solution": result[0].ObjectiveValue(),
        }
        if include_schedule_data:
            with open(resource_cost_assignments) as assignment_file:
                assignments = json.load(assignment_file)
            available_resources = list(dict.fromkeys(
                str(assignment["resource"])
                for assignment in assignments
            ))
            response["schedule_data"] = ScheduleData.from_solver(
                result[0],
                result[1],
                resources=available_resources,
            ).to_dict()
        result_queue.put(response)

    return result_queue

def fallback_result(reason="unknown"):
    """
    Define your fallback behavior here depending on your use case:
    - Return a best-effort heuristic solution
    - Return the last known good solution
    - Skip this iteration and continue
    - Raise an alert for human review
    """
    return {
        "status": "fallback",
        "reason": reason,
        "solution": None  # or your heuristic
    }


if __name__ == "__main__":
    print(sys.argv)
    # Stopping conditions for loop
    maxIterations = 5000 # total number of iterations
    timeoutLimit = 45 # Maximum number of seconds spend
    search_strat = "contention"

    pr = cProfile.Profile()
    pr.enable()
    direct_run_name = os.path.splitext(os.path.basename(sys.argv[6]))[0]
    schedule_output_dir = os.path.join(
        parent_path,
        "experiments",
        "schedules",
        f"{time.strftime('%Y-%m-%d_%H-%M-%S')}_{direct_run_name}_direct-run",
    )
    b_, bi_, foundObjectives_, b1, b2 = run_search(
        sys.argv,
        maxIterations,
        timeoutLimit,
        search_strat,
        schedule_output_dir=schedule_output_dir,
    )
    pr.disable()
    s = io.StringIO()
    ps = pstats.Stats(pr, stream=s).sort_stats('cumtime')
    ps.print_stats()

    with open('profile4.txt', 'w+') as f:
        f.write(s.getvalue())

    print(f"Best Plan found on iteration {bi_}: {b_}")
    print(foundObjectives_)
