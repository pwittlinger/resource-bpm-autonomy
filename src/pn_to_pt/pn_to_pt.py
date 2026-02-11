import pm4py
from pm4py.objects.conversion.wf_net import converter as pt_converter
from pm4py.visualization.process_tree import visualizer as pt_visualizer
from pathlib import Path

def load_petri_net(input_path: str|Path):

    input_path = Path(input_path)
    # Check if pnml file
    if input_path.suffix != '.pnml':
        raise ValueError(f"Input file must be a .pnml file, got {input_path.suffix}")
    
    net, im, fm  = pm4py.read_pnml(str(input_path))

    return net, im, fm

def pn_to_pt(net, im, fm):
    pt = pt_converter.apply(net, im, fm)
    return pt

def save_pt(pt, output_path: str|Path, filetype: str = 'ptml'):
    output_path = Path(output_path)
    # Check if output path is a .ptml file
    if output_path.suffix != f'.{filetype}':
        output_path = output_path.with_suffix(f'.{filetype}')
    
    pm4py.write_ptml(pt, str(output_path))

def save_pt_visualization(pt, output_path: str|Path, filetype: str = 'png'):
    output_path = Path(output_path)
    # Check if output path is a .png file
    if output_path.suffix != f'.{filetype}':
        output_path = output_path.with_suffix(f'.{filetype}')
    gviz = pt_visualizer.apply(pt)
    pt_visualizer.save(gviz, str(output_path))

def save_pn_visualization(net, im, fm, output_path: str|Path, filetype: str = 'png'):
    output_path = Path(output_path)
    # Check if output path is a .png file
    if output_path.suffix != f'.{filetype}':
        output_path = output_path.with_suffix(f'.{filetype}')
    gviz = pm4py.visualization.petri_net.visualizer.apply(net, im, fm)
    pm4py.visualization.petri_net.visualizer.save(gviz, str(output_path))

if __name__ == "__main__":
    INPUT_PATH = Path("input_files/a20g6.pnml")
    OUTPUT_PATH = Path(str(INPUT_PATH).replace("input_files", "output_files").replace(".pnml", ".ptml"))

    net, im, fm = load_petri_net(INPUT_PATH)
    pt = pn_to_pt(net, im, fm)
    save_pt(pt, OUTPUT_PATH)
    # add pt or pn into OUtput path
    save_pt_visualization(pt, OUTPUT_PATH.with_stem(OUTPUT_PATH.stem + "-pt"))
    save_pn_visualization(net, im, fm, OUTPUT_PATH.with_stem(OUTPUT_PATH.stem + "-pn"))



