import pddl
import re


def change(pddlContent:str, activity:str, resource:str, cost:float, additive:bool):
    firstIndex = pddlContent.find(f"add_action_{activity}_{resource}")
    actionCostMatch = re.search("\\d+\\.\\d+", pddlContent[firstIndex:])
    
    firstPart = pddlContent[:actionCostMatch.start()+firstIndex]
    secondPart = pddlContent[firstIndex+actionCostMatch.start()+len(actionCostMatch.group()):]

    newCost = float(actionCostMatch.group())

    if additive:
        newCost = newCost + cost
    else:
        newCost = newCost * cost


    return firstPart + str(newCost) + secondPart


if __name__ == "__main__":

    # I need to give it the file, so most likely the index (11)
    # i give a resource pair (a6 r0)
    # Need to also give value to update
    # if updating cannot be done in pddl parser
    # then I need to read in the file

    with open("planner/problem11_grounded.pddl") as f:
        content = f.read()
    
    print(len(content))

    #firstIndex = content.find("add_action_a6_R0")
    #print(content.find("increase",firstIndex))
    #print(re.search("\\d+\\.\\d+", content[firstIndex:]).group())

    #actionCostMatch = re.search("\\d+\\.\\d+", content[firstIndex:])
    #print(actionCostMatch.start())

    #firstPart = content[:actionCostMatch.start()+firstIndex]

    #secondPart = content[firstIndex+actionCostMatch.start()+len(actionCostMatch.group()):]

    newContent = change(content, "a6", "R0", 1.2, False)

    domain = pddl.parse_domain("planner/problem11_grounded.pddl")
    act_dicts = domain.actions
    resource:str = "R0"
    for act in act_dicts:
        if (not (act.name.startswith("add_action") and act.name.endswith(resource))):
            continue    
        print(act.name)
        curE = str(act.effect)
        foundMatch = re.search("\\d+\\.\\d+", curE)
        old_num = float(foundMatch.group())
        new_num = old_num*0.76
        d = curE.replace(foundMatch.group(), str(new_num))
        print(act.effect)

    print(domain)