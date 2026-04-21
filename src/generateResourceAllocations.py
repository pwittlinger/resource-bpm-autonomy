import os
from gen_resources import gen_resources
from pn_to_pt import pn_to_pt
from pathlib import Path


if __name__ == "__main__":
    
    noResources = [3,5,7,12]

    petriNets = os.listdir(os.path.join("input_files", "petri_net"))

    

    for pn in petriNets:
        pnName = pn.removesuffix(".pnml")

        # Generate Process Tree from Petri net
        INPUT_PATH = Path(os.path.join("input_files", "petri_net", pn))
        OUTPUT_PATH = Path(str(INPUT_PATH).replace("input_files", "output_files").replace(".pnml", ".ptml"))
        net, im, fm = pn_to_pt.load_petri_net(INPUT_PATH)
        pt = pn_to_pt.pn_to_pt(net, im, fm)
        pn_to_pt.save_pt(pt, OUTPUT_PATH)
        # add pt or pn into Output path
        pn_to_pt.save_pt_visualization(pt, OUTPUT_PATH.with_stem(OUTPUT_PATH.stem + "-pt"))
        pn_to_pt.save_pn_visualization(net, im, fm, OUTPUT_PATH.with_stem(OUTPUT_PATH.stem + "-pn"))


        PT_INPUT_PATH = Path(f"output_files/petri_net/{pnName}.ptml")
        for nR in noResources:
           
            OUTPUT_PATH = Path(f"output_files/assignments/{pnName}_resource_{nR}.json")
            
            pt = gen_resources.load_process_tree(PT_INPUT_PATH)
            assignments = gen_resources.generate(pt, nR)
            gen_resources.save_as_json(assignments, OUTPUT_PATH)


