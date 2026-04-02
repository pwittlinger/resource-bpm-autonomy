import os
import traceback

import runner_propositionalized
import matplotlib.pyplot as plt
import ast
import datetime

args1 = ["dummy",
    "input_files/declare/a20g6_7_data_parsed.decl", 
        "input_files/xes_files/a20g6-prefix-conforming-2-10.xes", 
        "input_files/variable_values_multi_model.txt",
        "input_files/variable_substitutions_a20g6_7.decl.txt", 
        "input_files/assignments/a20g6_resource_3.json",
        "input_files/petri_net/a20g6.pnml"
            ]

args2 = ["dummy",
    "input_files/declare/a20g6_7_data_parsed.decl", 
        "input_files/xes_files/a20g6-prefix-conforming-3.xes", 
        "input_files/variable_values_multi_model.txt",
        "input_files/variable_substitutions_a20g6_7.decl.txt", 
        "input_files/assignments/a20g6_assignments_7.json",
        "input_files/petri_net/a20g6.pnml"
            ]

args3 = ["dummy",
    "input_files/declare/a40g17AND_7_data_parsed.decl", 
        "input_files/xes_files/a40g17AND-prefix-conforming-3.xes", 
        "input_files/variable_values_multi_model.txt",
        "input_files/variable_substitutions_a40g17AND_7.decl.txt", 
        "input_files/assignments/a40g17AND_assignments_3.json",
        "input_files/petri_net/a40g17AND.pnml"
            ]

args4 = ["dummy",
    "input_files/declare/a35g6_7_data_parsed.decl", 
        "input_files/xes_files/a35g6-prefix-1.xes", 
        "input_files/variable_values_multi_model.txt",
        "input_files/variable_substitutions_a35g6_7.decl.txt", 
        "input_files/assignments/a35g6_assignments_3.json",
        "input_files/petri_net/a35g6.pnml"
            ]



def show_trajectories(file_name):
    # Load data from file
    with open(file_name, "r") as f:
        trajectories = [ast.literal_eval(line.strip()) for line in f if line.strip()]

    # Plot
    fig, ax = plt.subplots(figsize=(12, 6))

    for i, trajectory in enumerate(trajectories):
        ax.plot(range(len(trajectory)), trajectory, marker="o", markersize=4, label=f"Trajectory {i + 1}")

    ax.set_xlabel("Iteration", fontsize=13)
    ax.set_ylabel("Value", fontsize=13)
    ax.set_title("Schedule Trajectories", fontsize=15)
    ax.legend(loc="upper right", fontsize=10)
    ax.grid(True, linestyle="--", alpha=0.5)

    plt.tight_layout()
    plt.savefig(f"{file_name}.png", dpi=150)
    #plt.show()
    #print("Plot saved to schedule_trajectories.png")


numberTraces = [10, 15, 20, 25]
petriNets = os.listdir(os.path.join("input_files", "petri_net"))
runTimes = [45,60,90,180]
noResources = [3,5,7,12]
prefixLength = [2]

if __name__=="__main__":


    timestamp = datetime.datetime.now(datetime.UTC).strftime('%Y-%m-%d_%H-%M-%S')

    varValues = os.path.join("input_files","variable_values_multi_model.txt")
    for pn in petriNets:
        petriPath = os.path.join("input_files", "petri_net", pn)
        pnName = pn.removesuffix(".pnml")

        declFile = os.path.join("input_files", "declare", f"{pnName}_7_data_parsed.decl")
        varSub =  os.path.join("input_files", "variable_substitutions",f"variable_substitutions_{pnName}_7.decl.txt")
        for nTraces in numberTraces:
            for nResource in noResources:
                                        
                    xesPath = os.path.join("input_files", "xes_files", f"{pnName}-prefix-conforming-2-{nTraces}.xes")
                    resourceAssignment = os.path.join("input_files", "assignments", f"{pnName}_resource_{nResource}.json")

                    cArgs  = ["dummy",declFile,xesPath,varValues,varSub,resourceAssignment,petriPath]

                    for runTime in runTimes:
                        for j in range(2):
                            try:
                                print(f"Running iter {j} for {pnName} with {nResource}")
                                b_, bi_, found_objectives= runner_propositionalized.run_search(cArgs, 500, runTime, "contention")
                                with open(f"experiments/{timestamp}-{pnName}-{nTraces}-{nResource}_{runTime}_contention.txt", "a") as f:
                                    f.write(str(found_objectives)+"\n")
                            except Exception as e:
                                traceback.print_exc()
                                continue

    exit()
    best_plans = []
    for j in range(0):
        try:
            print(f"Running iter {j}")
            #b_, bi_, found_objectives= runner.run_search(args1, 50, 150, "contention")
            b_, bi_, found_objectives= runner_propositionalized.run_search(args1, 500, 45, "contention")
            best_plans.append([bi_, b_])
            with open("experiments/best_schedule_shadow_cost2.txt", "a") as f:
                f.write(str(best_plans))
            with open(f"experiments/{timestamp}schedule_trajectories_shadow_propositional.txt", "a") as f:
                f.write(str(found_objectives)+"\n")
        except Exception as e:
            traceback.print_exc()
            continue


    best_plans = []
    for j in range(0):
        try:
            #b_, bi_, found_objectives = runner.run_search(args2, 50, 150, "contention")
            b_, bi_, found_objectives = runner_propositionalized.run_search(args2, 500, 45, "contention")
            best_plans.append([bi_, b_])
            with open("experiments/best_schedule_7_shadow_cost.txt", "a") as f:
                f.write(str(best_plans))
            with open(f"experiments/{timestamp}schedule_trajectories_7_shadow_propositional.txt", "a") as f:
                f.write(str(found_objectives)+"\n")
        except Exception as e:
            traceback.print_exc()
            continue
       
    #show_trajectories(f"{timestamp}schedule_trajectories_7_shadow_propositional.txt")
    best_plans = []
    for j in range(0):
        try:
            #b_, bi_, found_objectives = runner.run_search(args2, 50, 150, "contention")
            b_, bi_, found_objectives = runner_propositionalized.run_search(args2, 500, 45, "slack")
            best_plans.append([bi_, b_])
            with open("experiments/best_schedule_5_weak_update.txt", "a") as f:
                f.write(str(best_plans))
            with open(f"experiments/{timestamp}schedule_trajectories_5_weak_propositional.txt", "a") as f:
                f.write(str(found_objectives)+"\n")
        except Exception as e:
            traceback.print_exc()
            continue
    
    #show_trajectories("schedule_trajectories_5.txt")
    #
    #show_trajectories("schedule_trajectories_5_no_update.txt")
    
    #show_trajectories(f"{timestamp}schedule_trajectories_7_weak_propositional.txt")


    best_plans = []
    for j in range(2):
        try:
            #b_, bi_, found_objectives = runner.run_search(args2, 50, 150, "contention")
            b_, bi_, found_objectives = runner_propositionalized.run_search(args3, 500, 300, "contention")
            best_plans.append([bi_, b_])
            with open("experiments/best_a40g17AND_weak_update.txt", "a") as f:
                f.write(str(best_plans))
            with open(f"experiments/{timestamp}-a40g17AND_schedule_trajectories_3_contention_propositional.txt", "a") as f:
                f.write(str(found_objectives)+"\n")
        except Exception as e:
            traceback.print_exc()
            continue

        best_plans = []
    for j in range(2):
        try:
            #b_, bi_, found_objectives = runner.run_search(args2, 50, 150, "contention")
            b_, bi_, found_objectives = runner_propositionalized.run_search(args4, 500, 300, "contention")
            best_plans.append([bi_, b_])
            with open("experiments/best_a35g6AND_weak_update.txt", "a") as f:
                f.write(str(best_plans))
            with open(f"experiments/{timestamp}-a35g6_schedule_trajectories_3_contention_propositional.txt", "a") as f:
                f.write(str(found_objectives)+"\n")
        except Exception as e:
            traceback.print_exc()
            continue
    
    #show_trajectories("schedule_trajectories_5.txt")

    