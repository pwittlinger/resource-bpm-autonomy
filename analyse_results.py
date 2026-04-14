"""
Parse experiment result files and track the minimum (best) final cost
for each experimental setup.

File name format:
  <timestamp>_<name>_<instances>_<resources>_<search_time>[_contention].txt

Example:
  2026-04-01_12-57-59-a20g6-10-3_45_contention.txt
  └─ timestamp : 2026-04-01_12-57-59  (first 20 chars, ignored)
  └─ name      : a20g6
  └─ instances : 10
  └─ resources : 3
  └─ time      : 45

Each line in the file is one experiment run represented as a Python-style
list of floats in decreasing order (minimising cost).  We record the
lowest (last) value of each line.

Duplicate setups across different timestamps are merged: the global
minimum across all runs is kept.
"""

import ast
import re
from pathlib import Path
from collections import defaultdict


# ---------------------------------------------------------------------------
# Filename parser
# ---------------------------------------------------------------------------

# After stripping the 20-char timestamp prefix the remainder looks like:
#   a20g6-10-3_45_contention.txt   (name contains a hyphen-separated cluster)
# We capture:
#   name      – everything up to the first underscore that precedes the time
#   instances – first integer after the last hyphen in the name field
#   resources – second integer after that hyphen
#   time      – integer between the first and second underscores of the suffix
#
# Regex explained:
#   ^.{20}          skip the 20-char timestamp
#   ([^_]+)         capture `name` (e.g. "a20g6-10-3")
#   _(\d+)          capture `search_time`
#   (?:_[^.]*)?     optional suffix like "_contention"
#   \.txt$

FNAME_RE = re.compile(
    r"^.{20}"           # timestamp (ignored)
    r"([^_]+)"          # name field, e.g. "a20g6-10-3"
    r"_(\d+)"           # search time
    r"(?:_[^.]*)?"      # optional tag (_contention …)
    r"\.txt$"
)

# The name field itself encodes instances and resources as the last two
# hyphen-separated integers: e.g. "a20g6-10-3" → name="a20g6", inst=10, res=3
NAME_SUFFIX_RE = re.compile(r"^(.*?)-(\d+)-(\d+)$")


def parse_filename(fname: str):
    """
    Return (name, instances, resources, search_time) or None if the
    filename doesn't match the expected pattern.
    """
    m = FNAME_RE.match(fname)
    if not m:
        return None
    name_field, search_time = m.group(1), int(m.group(2))

    m2 = NAME_SUFFIX_RE.match(name_field)
    if not m2:
        return None
    name, instances, resources = m2.group(1), int(m2.group(2)), int(m2.group(3))

    return name, instances, resources, search_time


# ---------------------------------------------------------------------------
# File reader
# ---------------------------------------------------------------------------

def read_experiment_file(path: Path):
    """
    Read a file and return a list of minimum values, one per non-empty line.
    Each line must be a Python list literal of floats.
    """
    mins = []
    with open(path) as fh:
        for lineno, raw in enumerate(fh, 1):
            line = raw.strip()
            if not line:
                continue
            try:
                values = ast.literal_eval(line)
                if not isinstance(values, list) or not values:
                    raise ValueError("empty or non-list")
                mins.append(min(float(v) for v in values))
            except Exception as exc:
                print(f"  [WARN] {path.name} line {lineno}: {exc!r} – skipped")
    return mins


# ---------------------------------------------------------------------------
# Main aggregation
# ---------------------------------------------------------------------------

def collect_results(search_dir: str = "."):
    """
    Walk *search_dir* for *.txt files matching the naming convention,
    parse them, and return a dict keyed by (name, instances, resources,
    search_time) whose value is a list of per-run minimum costs collected
    across all matching files (timestamps merged).
    """
    results: dict[tuple, list[float]] = defaultdict(list)

    directory = Path(search_dir)
    txt_files = sorted(directory.glob("*.txt"))

    if not txt_files:
        print(f"No .txt files found in '{directory.resolve()}'.")
        return results

    for path in txt_files:
        parsed = parse_filename(path.name)
        if parsed is None:
            print(f"[SKIP] '{path.name}' – doesn't match expected pattern.")
            continue

        name, instances, resources, search_time = parsed
        key = (name, instances, resources, search_time)
        mins = read_experiment_file(path)

        print(
            f"[OK]   {path.name}  →  setup={key}  "
            f"runs={len(mins)}  mins={mins}"
        )
        results[key].extend(mins)

    return results


def summarise(results: dict):
    """Print a summary table of per-run best values and their variance."""
    if not results:
        print("\nNo results to summarise.")
        return

    import statistics

    print("\n" + "=" * 90)
    print(f"{'Setup (name, inst, res, time)':<40} {'Runs':>5}  {'Best values':<30}  {'Variance':>10}")
    print("-" * 90)
    for key in sorted(results):
        run_mins = results[key]          # one minimum per experiment line
        variance = statistics.stdev(run_mins) if len(run_mins) > 1 else 0.0
        mean = statistics.mean(run_mins) if len(run_mins) > 0 else 0.0
        print(
            f"{str(key):<40} {len(run_mins):>5}  "
            f"{str(run_mins):<30}  {mean:>10.2f}  {variance:>10.4f}"
        )
    print("=" * 90)


# ---------------------------------------------------------------------------
# Entry point
# ---------------------------------------------------------------------------

if __name__ == "__main__":
    import sys

    # Optionally pass a directory as the first argument; default is CWD.
    search_dir = sys.argv[1] if len(sys.argv) > 1 else "."

    search_dir = "experiments"
    print(f"Scanning directory: {Path(search_dir).resolve()}\n")
    results = collect_results(search_dir)
    summarise(results)