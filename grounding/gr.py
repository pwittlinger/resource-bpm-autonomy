import re

class PDDLWorkflowManager:
    def __init__(self, problem_file, grounded_file):
        self.problem_file = problem_file
        self.grounded_file = grounded_file
        
        # Aligned with PDDLLogicEvaluator structure
        self.universe = {}  # Maps types to lists of constants
        self.facts = set()     # Stores tuples: (predicate, (arg1, arg2))
        self.fluents = {}   # Stores {(function, (args)): value}
        
        # Predicates that do not change during search
        self.static_predicates = {
            "trace", "automaton", "goal_state", "final_t_state", 
            "initial_state", "associated", "can_work", "has_parameter", 
            "has_constraint", "has_substitution_value", "failure_state"
        }
        # Functions that do not change during search
        self.static_functions = {
            "trace_parameter", "majority_constraint", "minority_constraint",
            "interval_constraint_lower", "interval_constraint_higher",
            "equality_constraint", "inequality_constraint", "variable_value",
            "violation_cost", "activity_cost"
        }

    # --- STEP 1: PARSING ---

    def parse_inputs(self):
        """Extracts grounded action list and initial world state."""
        # [cite_start]Parse Grounded Actions from the text file [cite: 2]
        try:
            with open(self.grounded_file, 'r') as f:
                content = f.read()
                match = re.search(r'\[(.*?)\]', content, re.DOTALL)
                self.grounded_list = re.findall(r'\((.*?)\)', match.group(1)) if match else []
        except FileNotFoundError:
            self.grounded_list = []

        # Parse Problem PDDL for objects, facts, and fluents
        try:
            with open(self.problem_file, 'r') as f:
                pddl_clean = re.sub(r';.*', '', f.read()) # Strip comments
            
            # 1. Populate self.universe (Objects)
            obj_match = re.search(r'\(:objects\s+(.*?)\)', pddl_clean, re.DOTALL | re.IGNORECASE)
            if obj_match:
                parts = obj_match.group(1).split('-')
                current_consts = parts[0].split()
                for i in range(1, len(parts)):
                    tokens = parts[i].split()
                    type_name = tokens[0]
                    if type_name not in self.universe:
                        self.universe[type_name] = []
                    self.universe[type_name].extend(current_consts)
                    current_consts = tokens[1:]

            # 2. Populate self.facts and self.fluents (Init)
            init_match = re.search(r'\(:init\s+(.*?)\n\s*\)', pddl_clean, re.DOTALL | re.IGNORECASE)
            if init_match:
                raw_init = init_match.group(1)
                # Static Fluents
                for f_name, args, val in re.findall(r'\(\s*=\s*\(\s*(\w+)\s+([^)]*)\)\s*([\d.-]+)\s*\)', raw_init):
                    if f_name in self.static_functions:
                        self.fluents[(f_name, tuple(args.split()))] = float(val)
                # Static Predicates
                for p_name, args in re.findall(r'\(\s*([a-zA-Z_][\w-]*)\s+([^)]+)\)', raw_init):
                    if p_name in self.static_predicates:
                        self.facts.add((p_name, tuple(args.split())))
        except FileNotFoundError:
            print(f"Error: {self.problem_file} not found.")

    # --- STEP 2: LOGIC EVALUATION ---

    def evaluate_static_exists(self, a, s1, pn, vn):
        """Evaluates the static parts of the quantifier using self.universe, self.facts, and self.fluents."""
        val_vn = self.fluents.get(('variable_value', (vn,)), 0.0)
        
        # Iterate through constants in self.universe to resolve the existential quantifier
        for s2 in self.universe.get('automaton_state', []):
            # Check structural static conditions
            if ('automaton', (s1, a, s2)) in self.facts and \
               ('has_constraint', (a, pn, s1, s2)) in self.facts and \
               ('failure_state', (s2,)) not in self.facts:
                
                # Check numeric static conditions
                maj = self.fluents.get(('majority_constraint', (a, pn, s1, s2)), float('inf'))
                min_c = self.fluents.get(('minority_constraint', (a, pn, s1, s2)), float('-inf'))
                eq = self.fluents.get(('equality_constraint', (a, pn, s1, s2)), None)

                if val_vn > maj or val_vn < min_c or (eq is not None and val_vn == eq):
                    return True
        return False
    
    def evaluate_add_action_precondition(self, a):
        """
        Evaluates the static parts of the add_action quantifier:
        (exists (?s1 ?s2) (and (cur_s_state ?s1) (not (goal_state ?s1)) ...))
        Returns a list of valid ?s1 states that satisfy the static conditions.
        """
        valid_s1_states = []

        # Iterate through all possible s1 states
        for s1 in self.universe.get('automaton_state', []):
            # 1. Evaluate Static Checks for ?s1
            if ('goal_state', (s1,)) in self.facts:
                continue
            if ('failure_state', (s1,)) in self.facts:
                continue

            # 2. Check if there exists ANY s2 that satisfies the static transition
            found_valid_transition = False
            for s2 in self.universe.get('automaton_state', []):
                if ('automaton', (s1, a, s2)) in self.facts and \
                   ('failure_state', (s2,)) not in self.facts:
                    found_valid_transition = True
                    break
            
            if found_valid_transition:
                valid_s1_states.append(s1)
        
        return valid_s1_states
    
    def pddl_for_not_violated(self):
        pddl_string = "(and"
        for c in self.universe.get('constraint', []):
            pddl_string += f" (not (violated {c}))"
        pddl_string += ")"
        return pddl_string

    # --- STEP 3: DOMAIN GENERATION ---

    def generate_grounded_domain(self, output_path):
        """Processes grounded actions and applies partial grounding."""
        actions_pddl = []
        for entry in self.grounded_list:
            tokens = entry.split()
            action_type = tokens[0]
            
            # --- Logic for add_parameter (from previous step) ---
            if action_type == "add_parameter":
                a, s1, pn, vn = tokens[1], tokens[2], tokens[3], tokens[4]
                if self.evaluate_static_exists(a, s1, pn, vn):
                    val = self.fluents.get(('variable_value', (vn,)), 0.0)
                    pddl = f"""\t(:action {entry.replace(' ', '_')}
        :parameters ()
        :precondition (and 
            (complete_sync {a}) (after_add) (not (after_add_check)) 
            (cur_s_state {s1}) (not (has_added_parameter_aut {a} {pn} {s1}))
        )
        :effect (and 
            (has_added_parameter_aut {a} {pn} {s1}) 
            (assign (added_parameter_aut {a} {pn} {s1}) {val})
        )
\t)"""
                    actions_pddl.append(pddl)

            # --- Logic for add_action ---
            elif action_type == "add_action":
                a, r = tokens[1], tokens[2]
                
                # Check static activity-resource constraint
                if ('can_work', (a, r)) in self.facts:
                    valid_s1_list = self.evaluate_add_action_precondition(a)
                    
                    if valid_s1_list:
                        # Convert the list of valid states into an OR block
                        if len(valid_s1_list) == 1:
                            s1_condition = f"(cur_s_state {valid_s1_list[0]})"
                        else:
                            s1_condition = "(or " + " ".join([f"(cur_s_state {s})" for s in valid_s1_list]) + ")"
                        
                        # Fetch static activity cost
                        cost = self.fluents.get(('activity_cost', (a, r)), 0.0)

                        constraint_not_violated = self.pddl_for_not_violated()

                        pddl = f"""\t(:action {entry.replace(' ', '_')}
        :parameters ()
        :precondition (and 
            (not (after_add)) (not (complete_sync {a})) (not (after_sync)) 
            (not (failure)) (not (after_add_check)) (recovery_finished)
            {s1_condition} {constraint_not_violated}
        )
        :effect (and 
            (increase (total_cost) {int(cost)}) 
            (after_add) (complete_sync {a})
        )
\t)"""
                        actions_pddl.append(pddl)

    
    


        with open(output_path, 'w') as f:
            f.write("(define (domain partially_grounded_domain)\n")
            f.write("  (:requirements :typing :strips :fluents)\n\n")
            f.write("\n\n".join(actions_pddl))
            f.write("\n)")
        print(f"Simplified domain written to {output_path}")

# --- EXECUTION ---
manager = PDDLWorkflowManager(r"grounding\input\problem1.pddl", r"grounding\input\grounded_actions.txt")
manager.parse_inputs()
manager.generate_grounded_domain('grounded_domain.pddl')