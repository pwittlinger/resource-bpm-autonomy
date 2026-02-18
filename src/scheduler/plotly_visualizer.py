import pandas as pd
import plotly.express as px

def visualize_schedule_plotly(solver, all_tasks):
    """
    Visualizes the schedule using an interactive Plotly Gantt chart.
    """
    schedule_data = []

    for instance_id, task_dict in all_tasks.items():
        for task_name, task_info in task_dict.items():
            start_var, end_var, interval_var, res, release_time = task_info  # Unpack the tuple
            start_val = solver.Value(start_var)
            finish_val = solver.Value(end_var)
            schedule_data.append({
                'Instance_id': str(instance_id),
                'Resource': res,
                'Task': task_name,
                'Start': start_val,
                'Finish': finish_val,
                'Duration': finish_val - start_val
            })

    if not schedule_data:
        print("No data to visualize.")
        return

    # Create DataFrame
    df = pd.DataFrame(schedule_data)

    # Plotly timeline requires a 'Start' and 'Finish' but usually as dates.
    # We use px.timeline and then convert the X-axis back to linear integers.
    fig = px.timeline(
        df, 
        x_start="Start", 
        x_end="Finish", 
        y="Resource", 
        color="Instance_id",
        hover_data={
            'Instance_id': True,
            'Task': True,
            'Resource': True,
            'Start': True, 
            'Finish': True,
            'Duration': True
        },
        title=f"Interactive Schedule Visualization (Makespan: {int(solver.ObjectiveValue())})"
    )

    # MAGIC STEP: Force the X-axis to display as integers instead of dates
    fig.layout.xaxis.type = 'linear'
    
    # Map the data points to the linear scale
    for i, data in enumerate(fig.data):
        # Calculate the actual width based on our integer values
        # Plotly timeline internally converts dates to milliseconds
        data.x = df[df['Instance_id'] == data.name]['Duration'].tolist()
        data.base = df[df['Instance_id'] == data.name]['Start'].tolist()

    # UI Tweaks
    fig.update_yaxes(autorange="reversed") # Highest resource at the top
    fig.update_layout(
        xaxis_title="Time Units",
        yaxis_title="Resource / Machine",
        legend_title="Process Instances",
        hoverlabel=dict(bgcolor="white", font_size=12)
    )

    fig.show()