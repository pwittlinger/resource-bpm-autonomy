import re

def returnPDDLHeader():
    return """(define (domain trace-alignment)

  (:requirements :strips :typing :equality :adl :fluents :action-costs)

  (:types activity automaton_state trace_state parameter_name value_name constraint resource)


  (:predicates 
    ;; TRACES AND AUTOMATONS
    (trace ?t1 - trace_state ?a - activity ?t2 - trace_state)
    (automaton ?s1 - automaton_state ?a - activity ?s2 - automaton_state)
    (cur_t_state ?t - trace_state)
    (cur_s_state ?s - automaton_state)
    (goal_state ?s - automaton_state)
    (final_t_state ?t - trace_state)
    (violated ?c - constraint)
    (initial_state ?s1 - automaton_state) 
    
    (associated ?s1 - automaton_state ?c - constraint)
    (can_work ?a - activity ?r - resource)

    ;; PARAMETER AND CONSTRAINT DECLARATION
    (has_parameter ?a - activity ?pn - parameter_name ?t1 - trace_state ?t2 - trace_state)
    (has_constraint ?a - activity ?pn - parameter_name ?s1 - automaton_state ?s2 - automaton_state)

    ; Predicates to keep track of planner progress
    (invalid ?s1 - automaton_state ?a - activity ?s2 - automaton_state)
    (complete_sync ?a - activity)
    (after_sync)
    (after_add)
    (after_add_check)

    (recovery_finished)

    ; Declare this to indicate that such activity-parameter-value assignment exists.
    (has_substitution_value ?vn - value_name ?a - activity ?pn - parameter_name)
    ; Indicates that the new activity has a new (defined) parameter.
    (has_added_parameter_aut ?a - activity ?par - parameter_name ?s1 - automaton_state)

    ; Used in the problem definition to indicate that this state must not be reached. In that case, the trace is **automatically** failed.
    (failure_state ?s - automaton_state)
    ; Used to indicate that the trace alignment couldn't possibly complete: prune -> less branching -> heap won't kaboom.
    (failure)

  )

  (:functions
    (total_cost)

    ; There exists a value connected to the activity that occures between the two trace states.
    (trace_parameter ?a - activity ?pn - parameter_name ?t1 - trace_state ?t2 - trace_state)
    (majority_constraint ?a - activity ?pn - parameter_name ?s1 - automaton_state ?s2 - automaton_state)
    (minority_constraint ?a - activity ?pn - parameter_name ?s1 - automaton_state ?s2 - automaton_state)
    (interval_constraint_lower ?a - activity ?pn - parameter_name ?s1 - automaton_state ?s2 - automaton_state)
    (interval_constraint_higher ?a - activity ?pn - parameter_name ?s1 - automaton_state ?s2 - automaton_state)
    (equality_constraint ?a - activity ?pn - parameter_name ?s1 - automaton_state ?s2 - automaton_state)
    (inequality_constraint ?a - activity ?pn - parameter_name ?s1 - automaton_state ?s2 - automaton_state)

    ;; VARIABLES SUBSTITUTION / ADDITION
    (variable_value ?var - value_name)
    (added_parameter_aut ?a - activity ?par - parameter_name ?s1 - automaton_state)
    ;; Cost functions
    (violation_cost ?c - constraint)
    (activity_cost ?a - activity ?r - resource)

  )
    
    """


def get_instantiated_data(file_path):
    # Templates including all actions from your domain
    templates = {
        "add_action": {
            "params": ["?a", "?r"],
            "pre": "(and (not (after_add)) (not (complete_sync ?a)) (not (after_sync)) (not (failure)) (not (after_add_check)) (recovery_finished) (can_work ?a ?r) (not (exists (?c - constraint) (violated ?c))) (exists (?s1 ?s2 - automaton_state) (and (cur_s_state ?s1) (not (goal_state ?s1)) (not (failure_state ?s1)) (automaton ?s1 ?a ?s2) (not (failure_state ?s2)))))",
            "eff": "(and (increase (total_cost) (activity_cost ?a ?r)) (after_add) (complete_sync ?a))"
        },
        "add_parameter": {
            "params": ["?a", "?s1", "?pn", "?vn"],
            "pre": "(and (complete_sync ?a) (after_add) (has_substitution_value ?vn ?a ?pn) (cur_s_state ?s1) (not (goal_state ?s1)) (not (has_added_parameter_aut ?a ?pn ?s1)) (not (after_add_check)) (exists (?s2 - automaton_state) (and (automaton ?s1 ?a ?s2) (has_constraint ?a ?pn ?s1 ?s2) (not (failure_state ?s2)) (or (> (variable_value ?vn) (majority_constraint ?a ?pn ?s1 ?s2)) (< (variable_value ?vn) (minority_constraint ?a ?pn ?s1 ?s2)) (= (variable_value ?vn) (equality_constraint ?a ?pn ?s1 ?s2)) (> (variable_value ?vn) (inequality_constraint ?a ?pn ?s1 ?s2)) (< (variable_value ?vn) (inequality_constraint ?a ?pn ?s1 ?s2))))))",
            "eff": "(and (increase (total_cost) 0) (has_added_parameter_aut ?a ?pn ?s1) (assign (added_parameter_aut ?a ?pn ?s1) (variable_value ?vn)))"
        },
        "check_added_parameter_model": {
            "params": ["?a"],
            "pre": "(and (complete_sync ?a) (after_add) (not (after_add_check)))",
            "eff": "(and (after_add_check) (not (after_add)) (forall (?pn - parameter_name ?s1 - automaton_state ?s2 - automaton_state) (when (and (cur_s_state ?s1) (automaton ?s1 ?a ?s2) (has_constraint ?a ?pn ?s1 ?s2)) (invalid ?s1 ?a ?s2))))"
        },
        "add_move_automata": {
            "params": ["?a"],
            "pre": "(and (complete_sync ?a) (not (after_add)) (after_add_check) (exists (?s1 - automaton_state ?s2 - automaton_state)  (and (not (goal_state ?s1)) (not (invalid ?s1 ?a ?s2)) (cur_s_state ?s1) (automaton ?s1 ?a ?s2))))",
            "eff": "(and (not (after_add_check)) (not (complete_sync ?a)) (forall (?s1 - automaton_state ?s2 - automaton_state) (when (and (automaton ?s1 ?a ?s2) (cur_s_state ?s1) (not (invalid ?s1 ?a ?s2))) (and (not (cur_s_state ?s1)) (cur_s_state ?s2)))))"
        },
        "validate-payload": {
            "params": ["?t1", "?a", "?t2"],
            "pre": "(and (cur_t_state ?t1) (trace ?t1 ?a ?t2) (not (after_sync)) (not (after_add)) (not (failure)) (not (complete_sync ?a)) (not (after_add_check)) (not (exists (?c - constraint) (violated ?c))) (not (recovery_finished)) (exists (?s1 ?s2 - automaton_state) (and (cur_s_state ?s1) (not (failure_state ?s1)) (not (goal_state ?s1)) (automaton ?s1 ?a ?s2) (not (invalid ?s1 ?a ?s2)))))",
            "eff": "(and (after_sync) (forall (?pn - parameter_name ?s1 - automaton_state ?s2 - automaton_state) (when (and (cur_s_state ?s1) (automaton ?s1 ?a ?s2) (has_constraint ?a ?pn ?s1 ?s2) (or (not (has_parameter ?a ?pn ?t1 ?t2)) (< (trace_parameter ?a ?pn ?t1 ?t2) (majority_constraint ?a ?pn ?s1 ?s2)))) (invalid ?s1 ?a ?s2))))"
        },
        "sync-actions": {
            "params": ["?t1", "?t2", "?a"],
            "pre": "(and (not (after_add)) (not (failure)) (not (after_add_check)) (not (complete_sync ?a)) (after_sync) (cur_t_state ?t1) (trace ?t1 ?a ?t2))",
            "eff": "(and (not (cur_t_state ?t1)) (cur_t_state ?t2) (when (final_t_state ?t2) (recovery_finished)) (not (after_sync)) (forall (?s1 - automaton_state ?s2 - automaton_state) (when (and (not (invalid ?s1 ?a ?s2)) (automaton ?s1 ?a ?s2) (cur_s_state ?s1)) (cur_s_state ?s2))))"
        },
        "reset": {
            "params": ["?c"],
            "pre": "(and (violated ?c) (not (after_sync)) (not (after_add)) (not (after_add_check)))",
            "eff": "(and (increase (total_cost) (violation_cost ?c)) (not (failure)) (not (violated ?c)))"
        },
        "skip-unused": {
            "params": ["?t1", "?a", "?t2"],
            "pre": "(and (cur_t_state ?t1) (trace ?t1 ?a ?t2) (not (recovery_finished)) (not (exists (?s1 - automaton_state ?s2 - automaton_state) (automaton ?s1 ?a ?s2))))",
            "eff": "(and (not (cur_t_state ?t1)) (cur_t_state ?t2) (when (final_t_state ?t2) (recovery_finished)))"
        }
    }

    try:
        with open(file_path, 'r') as f:
            raw_text = f.read()
        
        data_match = re.search(r'\[(.*?)\]', raw_text, re.DOTALL) # 
        if not data_match: return []
        
        grounded_entries = re.findall(r'\((.*?)\)', data_match.group(1)) # 
        results = []

        for entry in grounded_entries:
            tokens = entry.split()
            name, values = tokens[0], tokens[1:]
            
            if name in templates:
                action = templates[name]
                pre_inst = action['pre']
                eff_inst = action['eff']
                
                # Replace parameters using regex word boundaries
                for param, val in zip(action['params'], values):
                    pattern = re.escape(param) + r'(?!\w)' 
                    pre_inst = re.sub(pattern, val, pre_inst)
                    eff_inst = re.sub(pattern, val, eff_inst)
                
                results.append({
                    "original": entry,
                    "precondition": pre_inst,
                    "effect": eff_inst
                })
        return results
    except FileNotFoundError:
        return []

def export_to_pddl(instantiated_actions, output_file):
    with open(output_file, 'w') as f:
        f.write(returnPDDLHeader())
        for item in instantiated_actions:
            original = item['original']
            # Create the action header as requested
            action_header = "\t(:action " + original.replace(" ", "_")
            
            f.write(f"{action_header}\n")
            f.write(f"\t\t:parameters ()\n") # Grounded actions have no parameters
            f.write(f"\t\t:precondition {item['precondition']}\n")
            f.write(f"\t\t:effect {item['effect']}\n")
            f.write("\t)\n\n") # Close the action bracket
        f.write(")")
    print(f"Successfully exported {len(instantiated_actions)} actions to {output_file}")

# Execution
grounded_data = get_instantiated_data("grounding\input\grounded_actions.txt")
export_to_pddl(grounded_data, 'instantiated_domain.pddl')