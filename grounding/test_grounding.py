from PDDLLoader import PDDLLoader
from PDDLEvaluator import PDDLEvaluator

# --- Configuration with your provided Objects ---

pddl_file = r"C:\Users\paulw\Desktop\dfa-test\output\problem1.pddl"
# --- Execution ---
p = PDDLLoader(pddl_file)

#evaluator = PDDLEvaluator(p.get_pddl_facts())
evaluator = PDDLEvaluator( facts=p.get_pddl_facts(),fluents=p.get_pddl_fluents(),universe=p.get_pddl_universe())

# Load your actual PDDL data here
#with open(pddl_file, 'r') as f:
#    evaluator.load_pddl_facts(f.read())
#
# Example test for a grounded action
# (add_parameter a16 S6 integer v5)
success, found_s2 = evaluator.evaluate_add_parameter_exists("a16", "sDEC1_1", "integer", "v15")

if success:
    print(f"Condition Verified: s2 found as {found_s2}")
else:
    print("Condition False: No valid s2 satisfies the guards.")