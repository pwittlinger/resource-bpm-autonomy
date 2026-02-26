import re

class PDDLLoader:

    def __init__(self, file_path):
        self.pddl_content = self.load_pddl_content(file_path)
        self.universe = self.parse_pddl_objects(file_path)
        self.facts = set()
        self.fluents = {}
        
        self.load_pddl_facts()

    def load_pddl_content(self, file_path):
        try:
         with open(file_path, 'r') as f:
                #self.pddl_content = f.read()
                return f.read()
        except FileNotFoundError:
            print(f"Error: File {file_path} not found.")
            return {}

    def parse_pddl_objects(self,file_path):
        """
        Parses the (:objects ...) block of a PDDL problem file and returns
        a dictionary mapping types to lists of constants.
        """
        my_objects = {}
        
        try:
            #with open(file_path, 'r') as f:
            #    content = f.read()
            content = self.pddl_content
            
            # 1. Remove comments and find the :objects block
            content = re.sub(r';.*', '', content)  # Remove semicolon comments
            objects_match = re.search(r'\(:objects\s+(.*?)\)', content, re.DOTALL | re.IGNORECASE)
            
            if not objects_match:
                print("No (:objects) block found in the file.")
                return {}

            objects_text = objects_match.group(1).strip()
            
            # 2. Split by hyphen to separate constants from types
            # Example text: "S18 S16 - automaton_state categorical - parameter_name"
            # We split into parts like ["S18 S16 ", " automaton_state categorical ", " parameter_name"]
            parts = objects_text.split('-')
            
            current_constants = []
            for i, part in enumerate(parts):
                tokens = part.split()
                if i == 0:
                    # The first part is always just constants
                    current_constants = tokens
                else:
                    # Every subsequent part starts with a TYPE followed by more CONSTANTS
                    type_name = tokens[0]
                    remaining_constants = tokens[1:]
                    
                    # Assign constants to this type
                    if type_name not in my_objects:
                        my_objects[type_name] = []
                    my_objects[type_name].extend(current_constants)
                    
                    # The remaining tokens become the constants for the NEXT type in the loop
                    current_constants = remaining_constants
                    
            return my_objects

        except FileNotFoundError:
            print(f"Error: File {file_path} not found.")
            return {}

    def load_pddl_facts(self):
        """
        Parses predicates and numeric fluents from PDDL.
        Handles: (predicate arg1 arg2) and (= (fluent arg1) value)
        """

        #with open(pddl_file, 'r') as f:
#    evaluator.load_pddl_facts(f.read())
        # 1. Parse numeric fluents: (= (function_name arg1 arg2) 10.5)
        # This regex specifically targets the (= (name args) value) structure
        fluent_pattern = r'\(\s*=\s*\(\s*(\w+)\s+([^)]*)\)\s*([\d.-]+)\s*\)'
        for name, args_str, value in re.findall(fluent_pattern, self.pddl_content):
            args = tuple(args_str.split())
            self.fluents[(name, args)] = float(value)

        # 2. Parse predicates: (predicate_name arg1 arg2)
        # We find all balanced parentheses and exclude those starting with '='
        predicate_pattern = r'\(\s*([a-zA-Z_][\w-]*)\s+([^)]+)\)'
        for name, args_str in re.findall(predicate_pattern, self.pddl_content):
            if name == '=': continue
            args = tuple(args_str.split())
            self.facts.add((name, args))

    def get_pddl_universe(self):
        return self.universe
    def get_pddl_facts(self):
        return self.facts
    def get_pddl_fluents(self):
        return self.fluents