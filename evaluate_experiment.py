import os
import traceback
import runner
import runner_propositionalized
import matplotlib.pyplot as plt
import ast
from datetime import datetime

args1 = ["dummy",
    "input_files/declare/a20g6_7_data_parsed.decl", 
        "input_files/xes_files/a20g6-prefix-conforming-3.xes", 
        "input_files/variable_values_multi_model.txt",
        "input_files/variable_substitutions_a20g6_7.decl.txt", 
        "input_files/assignments/a20g6_assignments_t.json",
        "input_files/petri_net/a20g6.pnml"
            ]

args2 = ["dummy",
    "input_files/declare/a20g6_7_data_parsed.decl", 
        "input_files/xes_files/a20g6-prefix-conforming-3.xes", 
        "input_files/variable_values_multi_model.txt",
        "input_files/variable_substitutions_a20g6_7.decl.txt", 
        "input_files/assignments/a20g6_assignments_5.json",
        "input_files/petri_net/a20g6.pnml"
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
    plt.show()
    print("Plot saved to schedule_trajectories.png")


if __name__=="__main__":
    timestamp = datetime.utcnow().strftime('%Y-%m-%d_%H-%M-%S')
    best_plans = []
    for j in range(10):
        try:
            print(f"Running iter {j}")
            #b_, bi_, found_objectives= runner.run_search(args1, 50, 150, "contention")
            b_, bi_, found_objectives= runner_propositionalized.run_search(args1, 50, 45, "contention")
            best_plans.append([bi_, b_])
            with open("best_schedule_shadow_cost2.txt", "a") as f:
                f.write(str(best_plans))
            with open(f"{timestamp}schedule_trajectories_shadow_propositional.txt", "a") as f:
                f.write(str(found_objectives)+"\n")
        except Exception as e:
            traceback.print_exc()
            continue

    show_trajectories("schedule_trajectories_shadow_propositional.txt")
    best_plans = []
    for j in range(10):
        try:
            print(f"Running iter {j}")
            #b_, bi_, found_objectives= runner.run_search(args1, 50, 150, "contention")
            b_, bi_, found_objectives= runner_propositionalized.run_search(args1, 50, 45, "slack")
            best_plans.append([bi_, b_])
            with open("best_schedule_weak_update.txt", "a") as f:
                f.write(str(best_plans))
            with open(f"{timestamp}schedule_trajectories_weak_propositional.txt", "a") as f:
                f.write(str(found_objectives)+"\n")
        except Exception as e:
            traceback.print_exc()
            continue


    #show_trajectories("schedule_trajectories.txt")
    #show_trajectories("schedule_trajectories_weak_update.txt")
    #show_trajectories("schedule_trajectories_weak_propositional.txt")
    

    best_plans = []
    for j in range(10):
        try:
            #b_, bi_, found_objectives = runner.run_search(args2, 50, 150, "contention")
            b_, bi_, found_objectives = runner_propositionalized.run_search(args2, 50, 45, "contention")
            best_plans.append([bi_, b_])
            with open("best_schedule_5_shadow_cost.txt", "a") as f:
                f.write(str(best_plans))
            with open(f"{timestamp}schedule_trajectories_5_shadow_propositional.txt", "a") as f:
                f.write(str(found_objectives)+"\n")
        except Exception as e:
            traceback.print_exc()
            continue
       
    #show_trajectories("schedule_trajectories_5_shadow_propositional.txt")
    best_plans = []
    for j in range(10):
        try:
            #b_, bi_, found_objectives = runner.run_search(args2, 50, 150, "contention")
            b_, bi_, found_objectives = runner_propositionalized.run_search(args2, 50, 45, "slack")
            best_plans.append([bi_, b_])
            with open("best_schedule_5_weak_update.txt", "a") as f:
                f.write(str(best_plans))
            with open(f"{timestamp}schedule_trajectories_5_weak_propositional.txt", "a") as f:
                f.write(str(found_objectives)+"\n")
        except Exception as e:
            traceback.print_exc()
            continue
    
    #show_trajectories("schedule_trajectories_5.txt")
    #
    #show_trajectories("schedule_trajectories_5_no_update.txt")
    
    #show_trajectories("schedule_trajectories_5_weak_propositional.txt")




    