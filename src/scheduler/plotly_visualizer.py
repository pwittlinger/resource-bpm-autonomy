import argparse
import re
from pathlib import Path

import pandas as pd
import plotly.express as px
import plotly.graph_objects as go

from src.scheduler.schedule_data import ScheduleData

import os
# Replace with the actual path to your Chrome or Chromium binary
os.environ["BROWSER_PATH"] = "/usr/bin/google-chrome"


def _natural_sort_key(value):
    """Sort resource names predictably while respecting embedded numbers."""
    return [
        int(part) if part.isdigit() else part.casefold()
        for part in re.split(r"(\d+)", str(value))
    ]


def build_schedule_data(solver, all_tasks, name=None, resources=None):
    """Compatibility wrapper for constructing a ScheduleData object."""
    return ScheduleData.from_solver(
        solver,
        all_tasks,
        name=name,
        resources=resources,
    )


def save_schedule_data(schedule_data, file_path):
    """Compatibility wrapper for saving a ScheduleData object."""
    if not isinstance(schedule_data, ScheduleData):
        raise TypeError("schedule_data must be a ScheduleData object.")
    return schedule_data.save(file_path)


def load_schedule_data(file_path):
    """Compatibility wrapper for loading a ScheduleData object."""
    return ScheduleData.load(file_path)


def save_schedule_plotly_png(
    figure,
    output_folder,
    file_name="schedule.png",
    width=1600,
    height=900,
    scale=2,
):
    """Save a Plotly schedule figure as a PNG in the specified folder."""
    output_folder = Path(output_folder)
    output_folder.mkdir(parents=True, exist_ok=True)

    file_name = Path(file_name)
    if file_name.suffix.lower() != ".png":
        file_name = file_name.with_suffix(".png")

    output_path = output_folder / file_name
    figure.write_image(
        str(output_path),
        format="png",
        width=width,
        height=height,
        scale=scale,
    )
    return output_path


def visualize_schedule_plotly(
    solver=None,
    all_tasks=None,
    schedule_data=None,
    show=True,
    x_axis_max=None,
):
    """
    Visualizes a schedule using an interactive Plotly Gantt chart.

    The schedule can be supplied as a ScheduleData object, or as a solver
    together with all_tasks for compatibility with the original API.
    If x_axis_max is provided, the horizontal axis spans from 0 to that value.
    If it is smaller than the latest task finish, the latest finish is used.
    """
    if isinstance(solver, ScheduleData):
        if all_tasks is not None or schedule_data is not None:
            raise ValueError(
                "Provide either a ScheduleData object, or solver and all_tasks."
            )
        schedule_data = solver
        solver = None

    if schedule_data is not None:
        if solver is not None or all_tasks is not None:
            raise ValueError(
                "Provide either solver and all_tasks, or schedule_data, not both."
            )
        if not isinstance(schedule_data, ScheduleData):
            raise TypeError("schedule_data must be a ScheduleData object.")
    else:
        if solver is None or all_tasks is None:
            raise ValueError(
                "Provide either solver and all_tasks, or schedule_data."
            )
        schedule_data = build_schedule_data(solver, all_tasks)

    if not schedule_data.tasks:
        print("No data to visualize.")
        return

    latest_finish = max(task["Finish"] for task in schedule_data.tasks)
    effective_x_axis_max = (
        max(x_axis_max, latest_finish)
        if x_axis_max is not None
        else None
    )

    # Create DataFrame
    df = pd.DataFrame(schedule_data.tasks)
    resource_order = sorted(
        schedule_data.resources,
        key=_natural_sort_key,
    )
    instance_order = sorted(
        df["Instance_id"].unique().tolist(),
        key=_natural_sort_key,
    )

    # Plotly timeline requires a 'Start' and 'Finish' but usually as dates.
    # We use px.timeline and then convert the X-axis back to linear integers.
    fig = px.timeline(
        df, 
        x_start="Start", 
        x_end="Finish", 
        y="Resource", 
        color="Instance_id",
        category_orders={
            "Resource": resource_order,
            "Instance_id": instance_order,
        },
        hover_data={
            'Instance_id': True,
            'Task': True,
            'Resource': True,
            'Start': True, 
            'Finish': True,
            'Duration': True
        },
        title=(
            "Interactive Schedule Visualization "
            f"(Makespan: {schedule_data.makespan})"
        )
    )

    # MAGIC STEP: Force the X-axis to display as integers instead of dates
    fig.layout.xaxis.type = 'linear'
    if effective_x_axis_max is not None:
        fig.update_xaxes(range=[0, effective_x_axis_max])
    
    # Map the data points to the linear scale
    for i, data in enumerate(fig.data):
        # Calculate the actual width based on our integer values
        # Plotly timeline internally converts dates to milliseconds
        data.x = df[df['Instance_id'] == data.name]['Duration'].tolist()
        data.base = df[df['Instance_id'] == data.name]['Start'].tolist()

    # Register resources without allocated tasks as categories on the axis.
    # Invisible points create the empty rows without adding legend entries.
    fig.add_trace(
        go.Scatter(
            x=[None] * len(resource_order),
            y=resource_order,
            mode="markers",
            marker={"opacity": 0},
            hoverinfo="skip",
            showlegend=False,
        )
    )

    # UI Tweaks
    fig.update_yaxes(
        categoryorder="array",
        categoryarray=resource_order,
        autorange="reversed",
    )
    fig.update_layout(
        xaxis_title="Time Units",
        yaxis_title="Resource",
        legend_title="Process Instances",
        font_size=24,
        hoverlabel=dict(bgcolor="white", font_size=12)
    )

    if show:
        fig.show()

    return fig


def main(argv=None):
    """Create a schedule PNG from a ScheduleData JSON file."""
    parser = argparse.ArgumentParser(
        description="Create a Plotly schedule PNG from a schedule JSON file."
    )
    parser.add_argument(
        "schedule_file",
        help="Path to a ScheduleData JSON file.",
    )
    parser.add_argument(
        "--output-folder",
        help="Folder for the PNG. Defaults to the JSON file's folder.",
    )
    parser.add_argument(
        "--file-name",
        help="PNG file name. Defaults to the JSON file name with .png.",
    )
    parser.add_argument(
        "--x-axis-max",
        type=int,
        help="Optional fixed maximum value for the X-axis.",
    )
    parser.add_argument(
        "--show",
        action="store_true",
        help="Also open the interactive Plotly visualization.",
    )
    args = parser.parse_args(argv)

    schedule_file = Path(args.schedule_file)
    output_folder = (
        Path(args.output_folder)
        if args.output_folder is not None
        else schedule_file.parent
    )
    file_name = args.file_name or f"{schedule_file.stem}.png"

    schedule_data = ScheduleData.load(schedule_file)
    figure = visualize_schedule_plotly(
        schedule_data,
        show=args.show,
        x_axis_max=args.x_axis_max,
    )
    if figure is None:
        raise ValueError("Cannot create a PNG for an empty schedule.")

    output_path = save_schedule_plotly_png(
        figure,
        output_folder,
        file_name,
    )
    print(f"Schedule PNG saved to: {output_path}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
