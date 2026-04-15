"""
Parse experiment result files and track minimum values per setup,
compare contention runs against benchmark files.

File name format:
  <timestamp(20)><n>-<instances>-<resources>_<search_time>_<tag>.txt

Example:
  2026-04-01_12-57-59-a20g6-10-3_45_contention.txt
  └─ timestamp : 2026-04-01_12-57-59  (first 20 chars, ignored)
  └─ name      : a20g6
  └─ instances : 10
  └─ resources : 3
  └─ time      : 45
  └─ tag       : contention  ← or "best-bench" / "initial-bench"

Duplicate setups across different timestamps are merged.
"""

import ast
import re
import statistics
from pathlib import Path
from collections import defaultdict

# ---------------------------------------------------------------------------
# Filename parser  (now also captures the tag)
# ---------------------------------------------------------------------------

FNAME_RE = re.compile(
    r"^.{20}"           # timestamp (ignored)
    r"([^_]+)"          # name field, e.g. "a20g6-10-3"
    r"_(\d+)"           # search time
    r"_([^.]+)"         # tag: contention / best-bench / initial-bench / ...
    r"\.txt$"
)

NAME_SUFFIX_RE = re.compile(r"^(.*?)-(\d+)-(\d+)$")


def parse_filename(fname: str):
    """
    Return (name, instances, resources, search_time, tag) or None.
    """
    m = FNAME_RE.match(fname)
    if not m:
        return None
    name_field, search_time, tag = m.group(1), int(m.group(2)), m.group(3)

    m2 = NAME_SUFFIX_RE.match(name_field)
    if not m2:
        return None
    name = m2.group(1)
    instances, resources = int(m2.group(2)), int(m2.group(3))

    return name, instances, resources, search_time, tag


def setup_key(parsed):
    name, instances, resources, search_time, _tag = parsed
    return (name, instances, resources, search_time)


# ---------------------------------------------------------------------------
# File readers
# ---------------------------------------------------------------------------

def read_trajectory_file(path: Path):
    """
    Read a contention-style file.
    Each line is a list literal; returns (per-run minima, full trajectories).
    """
    mins, trajectories = [], []
    with open(path) as fh:
        for lineno, raw in enumerate(fh, 1):
            line = raw.strip()
            if not line:
                continue
            try:
                values = ast.literal_eval(line)
                if not isinstance(values, list) or not values:
                    raise ValueError("empty or non-list")
                floats = [float(v) for v in values]
                mins.append(min(floats))
                trajectories.append(floats)
            except Exception as exc:
                print(f"  [WARN] {path.name} line {lineno}: {exc!r} – skipped")
    return mins, trajectories


def read_benchmark_file(path: Path):
    """
    Read a best-bench / initial-bench file.
    Each line is a single float; returns list of values.
    """
    values = []
    with open(path) as fh:
        for lineno, raw in enumerate(fh, 1):
            line = raw.strip()
            if not line:
                continue
            try:
                values.append(float(line))
            except ValueError as exc:
                print(f"  [WARN] {path.name} line {lineno}: {exc!r} – skipped")
    return values


# ---------------------------------------------------------------------------
# Collection
# ---------------------------------------------------------------------------

def collect_all(search_dir: str = "."):
    """
    Walk search_dir and return:
      contention_mins   – key → list of per-run minima
      contention_trajs  – key → list of full trajectory lists
      benchmarks        – key → {tag: [float, ...]}
    """
    contention_mins  = defaultdict(list)
    contention_trajs = defaultdict(list)
    benchmarks       = defaultdict(lambda: defaultdict(list))

    directory = Path(search_dir)
    txt_files = sorted(directory.glob("*.txt"))

    if not txt_files:
        print(f"No .txt files found in '{directory.resolve()}'.")
        return contention_mins, contention_trajs, benchmarks

    for path in txt_files:
        parsed = parse_filename(path.name)
        if parsed is None:
            print(f"[SKIP] '{path.name}' – doesn't match expected pattern.")
            continue

        key = setup_key(parsed)
        tag = parsed[4]

        if tag == "contention":
            mins, trajs = read_trajectory_file(path)
            contention_mins[key].extend(mins)
            contention_trajs[key].extend(trajs)
            print(f"[OK-C] {path.name}  →  setup={key}  runs={len(mins)}  mins={mins}")
        else:
            vals = read_benchmark_file(path)
            benchmarks[key][tag].extend(vals)
            print(f"[OK-B] {path.name}  →  setup={key}  tag={tag}  values={vals}")

    return contention_mins, contention_trajs, dict(benchmarks)


# ---------------------------------------------------------------------------
# Summary & comparison
# ---------------------------------------------------------------------------

def summarise(contention_mins: dict, benchmarks: dict):
    """
    Print per-setup contention stats, then for each benchmark tag show
    how close contention gets on average (absolute gap and % gap).
    """
    all_keys = sorted(set(contention_mins) | set(benchmarks))

    print("\n" + "=" * 100)
    print(f"{'Setup':<42} {'Runs':>4}  {'Contention mins':<32}  {'Variance':>10}")
    print("-" * 100)

    with open("summary.txt", "w") as f:
        f.write("pn;nInstances;nResources;time;nRuns;median;std;bestgap;initialgap\n")
        f.flush()

    for key in all_keys:
        txtwrite = ""
        runs = contention_mins.get(key, [])
        mean = statistics.median(runs)
        var  = statistics.stdev(runs) if len(runs) > 1 else 0.0
        print(f"{str(key):<42} {len(runs):>4}  {str(runs):<32}  median value: {mean}  std: {var:>10.4f}")
        print(key[0])
        #with open("summary.txt", "a") as f:
        #    f.write(f"{str(key[0])},{str(key[1])},{str(key[2])},{str(key[3])},{len(runs)},{mean},{var:.4f}\n")
        

        g1 = "nan"
        g2 = "nan"
        bench = benchmarks.get(key, {})
        if not bench:
            with open("summary.txt", "a") as f:
                f.write(f"{str(key[0])};{str(key[1])};{str(key[2])};{str(key[3])};{len(runs)};{mean};{var:.4f};{g1};{g2}\n")
            continue

        avg_contention = statistics.mean(runs) if runs else None

        for tag in sorted(bench):
            bench_vals = bench[tag]
            avg_bench  = statistics.mean(bench_vals)


            if avg_contention is not None:
                abs_gap = avg_contention - avg_bench
                pct_gap = 100.0 * abs_gap / avg_bench if avg_bench != 0 else float("nan")
                print(
                    f"  {'vs ' + tag + ':':<38} "
                    f"avg bench={avg_bench:.2f}  "
                    f"avg contention={avg_contention:.2f}  "
                    f"gap={abs_gap:+.2f}  ({pct_gap:+.2f}%)"
                )
            else:
                print(f"  vs {tag}: no contention data for this setup.")
            
            if tag == "best-bench":
                g1 = pct_gap
            elif tag == "initial-bench":
                g2 = pct_gap
        
        with open("summary.txt", "a") as f:
            f.write(f"{str(key[0])};{str(key[1])};{str(key[2])};{str(key[3])};{len(runs)};{mean};{var:.4f};{g1:.2f};{g2:.2f}\n")

    print("=" * 100)


# ---------------------------------------------------------------------------
# Plotting
# ---------------------------------------------------------------------------

def plot_trajectories(contention_trajs: dict, benchmarks: dict, search_dir: str = "."):
    """
    For each setup, plot all contention trajectories and draw horizontal
    reference lines for each available benchmark tag.
    """
    import matplotlib.pyplot as plt

    all_keys = sorted(set(contention_trajs) | set(benchmarks))

    BENCH_STYLES = {
        "best-bench":    dict(color="green",  linestyle="--", label="best-bench (avg)"),
        "initial-bench": dict(color="orange", linestyle=":",  label="initial-bench (avg)"),
    }

    for key in all_keys:
        trajs = contention_trajs.get(key, [])
        bench = benchmarks.get(key, {})
        name, instances, resources, search_time = key

        minimum_values = []

        fig, ax = plt.subplots(figsize=(12, 6))

        for i, traj in enumerate(trajs):
            min_val = min(traj)
            minimum_values.append(min_val)
            ax.plot(range(len(traj)), traj, marker="o", markersize=4,
                    label=f"Run {i + 1}")
            

        for tag, vals in sorted(bench.items()):
            avg = statistics.mean(vals)
            style = BENCH_STYLES.get(
                tag, dict(color="red", linestyle="-.", label=f"{tag} (avg)")
            )
            ax.axhline(avg, linewidth=2, **style)
        
        ax.axhline(statistics.mean(minimum_values), linewidth=2, color="black",  linestyle="--", label="Best solution found(avg)")
        ax.set_xlabel("Iteration", fontsize=13)
        ax.set_ylabel("Value", fontsize=13)
        ax.set_title(
            f"Trajectories – {name}  |  instances={instances}  "
            f"resources={resources}  time={search_time}s",
            fontsize=13,
        )
        ax.legend(loc="upper right", fontsize=9)
        ax.grid(True, linestyle="--", alpha=0.5)
        plt.tight_layout()

        #out_name = f"{name}_inst{instances}_res{resources}_t{search_time}.png"
        out_name = f"{name}_res{resources}_inst{instances}_t{search_time}.png"
        out_path = Path(search_dir) / out_name
        plt.savefig(out_path, dpi=150)
        plt.close()
        print(f"[PLOT] Saved → {out_path}")


# ---------------------------------------------------------------------------
# Entry point
# ---------------------------------------------------------------------------

if __name__ == "__main__":
    import sys

    search_dir = sys.argv[1] if len(sys.argv) > 1 else "."
    search_dir = "experiments"
    print(f"Scanning directory: {Path(search_dir).resolve()}\n")

    contention_mins, contention_trajs, benchmarks = collect_all(search_dir)
    summarise(contention_mins, benchmarks)
    #plot_trajectories(contention_trajs, benchmarks, search_dir)
