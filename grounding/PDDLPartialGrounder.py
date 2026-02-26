import re

class PDDLPartialGrounder:
    #def __init__(self, objects_dict, static_facts, static_fluents):
    def __init__(self, objects_dict):
        self.facts = set()
        self.fluents = {}
        self.universe = objects_dict
        #self.static_facts = static_facts # Set of tuples
        #self.static_fluents = static_fluents # Dict of {(name, args): val}
        self.static_facts = {
            "trace", "automaton", "goal_state", "final_t_state", 
            "initial_state", "associated", "can_work", "has_parameter", 
            "has_constraint", "has_substitution_value", "failure_state"
        }
        self.static_fluents = {
            "trace_parameter", "majority_constraint", "minority_constraint",
            "interval_constraint_lower", "interval_constraint_higher",
            "equality_constraint", "inequality_constraint", "variable_value",
            "violation_cost", "activity_cost"
        }


    


