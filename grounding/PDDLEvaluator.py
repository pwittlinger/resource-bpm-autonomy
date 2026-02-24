import re

class PDDLEvaluator:
    #def __init__(self, objects_dict):
    def __init__(self, facts, fluents, universe):
        """
        objects_dict: Dictionary mapping types to lists of constants.
        e.g., {'automaton_state': ['S18', 'sDEC1_1', ...]}
        """
        self.facts = facts
        self.fluents = fluents
        self.universe = universe

    def load_pddl_facts(self, pddl_content):
        """
        Parses predicates and numeric fluents from PDDL.
        Handles: (predicate arg1 arg2) and (= (fluent arg1) value)
        """
        # 1. Parse numeric fluents: (= (function_name arg1 arg2) 10.5)
        # This regex specifically targets the (= (name args) value) structure
        fluent_pattern = r'\(\s*=\s*\(\s*(\w+)\s+([^)]*)\)\s*([\d.-]+)\s*\)'
        for name, args_str, value in re.findall(fluent_pattern, pddl_content):
            args = tuple(args_str.split())
            self.fluents[(name, args)] = float(value)

        # 2. Parse predicates: (predicate_name arg1 arg2)
        # We find all balanced parentheses and exclude those starting with '='
        predicate_pattern = r'\(\s*([a-zA-Z_][\w-]*)\s+([^)]+)\)'
        for name, args_str in re.findall(predicate_pattern, pddl_content):
            if name == '=': continue
            args = tuple(args_str.split())
            self.facts.add((name, args))

    def check_predicate(self, name, *args):
        return (name, args) in self.facts

    def get_fluent_value(self, name, *args):
        """Returns the numeric value or 0.0 if the fluent isn't set."""
        return self.fluents.get((name, args), 0.0)

    def evaluate_add_parameter_exists(self, a, s1, pn, vn):
        """
        Evaluates the 'exists (?s2 - automaton_state)' condition.
        """
        val_vn = self.get_fluent_value('variable_value', vn)
        
        # Iterate only through the valid automaton_state list you provided
        for s2 in self.universe.get('automaton_state', []):
            # 1. AND Conditions
            cond_automaton = self.check_predicate('automaton', s1, a, s2)
            cond_constraint = self.check_predicate('has_constraint', a, pn, s1, s2)
            cond_not_fail = not self.check_predicate('failure_state', s2)

            if cond_automaton and cond_constraint and cond_not_fail:
                # 2. OR Conditions (Numeric Guards)
                # We check if at least one comparison holds true
                if (val_vn > self.get_fluent_value('majority_constraint', a, pn, s1, s2) or
                    val_vn < self.get_fluent_value('minority_constraint', a, pn, s1, s2) or
                    val_vn == self.get_fluent_value('equality_constraint', a, pn, s1, s2) or
                    val_vn != self.get_fluent_value('inequality_constraint', a, pn, s1, s2)):
                    
                    return True, s2 # Found a satisfying state
        
        return False, None
    


