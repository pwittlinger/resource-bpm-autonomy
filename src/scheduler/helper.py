import matplotlib.pyplot as plt
import matplotlib.cm as cm
import matplotlib.colors as mcolors
import numpy as np
from pathlib import Path


def plot_regret_rates(
    max_additional_cost: float,
    alpha: float,
    resource_stats: dict,
    output_path: str = "output_files/regret_rate_curves.png",
) -> None:
    """Heatmap of tax = α · u³ · (num_alternatives − 1) over (utilization, num_alternatives) space.

    Axes
    ----
    X-axis : resource utilization  u  ∈ [0, 1]
    Y-axis : number of alternatives   ∈ [0, max_alternatives]
    Color  : tax value at each (u, n) cell

    Overlaid elements
    -----------------
    - Contour lines mark evenly-spaced iso-tax levels.
    - Scatter dots show the current (utilization, num_alternatives) of every
      task-resource assignment, outlined in white for contrast.

    Args:
        max_additional_cost: Global maximum additional cost (for informational use).
        alpha:               Scaling factor in the tax formula.
        resource_stats:      Dict keyed by resource name containing:
                                 utilization (float): current utilization of the resource.
                                 tasks (dict): {task_name: {"additional_cost": ..., "num_alternatives": ..., ...}}
        output_path:         Destination file path for the saved figure.
    """
    # ------------------------------------------------------------------
    # 1. Build the tax surface over a fine grid
    # ------------------------------------------------------------------
    # Collect max alternatives for Y-axis range
    max_alt = 1
    for stats in resource_stats.values():
        for task_data in stats.get("tasks", {}).values():
            n = task_data.get("num_alternatives", 1)
            if n > max_alt:
                max_alt = n

    res = 300
    u_grid = np.linspace(0.0, 1.0, res)
    n_grid = np.linspace(0.0, float(max_alt), res)
    U, N = np.meshgrid(u_grid, n_grid)
    TAX = alpha * (U ** 3) * np.maximum(N - 1, 0)

    # ------------------------------------------------------------------
    # 2. Collect current assignment points
    # ------------------------------------------------------------------
    points: list[tuple[float, float, float, str]] = []  # (u, num_alt, tax, label)
    for resource, stats in resource_stats.items():
        u_r = stats.get("utilization", 0.0)
        for task, task_data in stats.get("tasks", {}).items():
            num_alt = task_data.get("num_alternatives", 1)
            tax = alpha * (u_r ** 3) * max(num_alt - 1, 0)
            points.append((u_r, float(num_alt), tax, f"{resource}\n{task}"))

    # ------------------------------------------------------------------
    # 3. Plot heatmap
    # ------------------------------------------------------------------
    fig, ax = plt.subplots(figsize=(10, 7))

    tax_max_val = float(TAX.max())
    tax_norm = mcolors.Normalize(vmin=0.0, vmax=tax_max_val)
    cmap = cm.get_cmap("plasma")

    im = ax.imshow(
        TAX,
        origin="lower",
        extent=[0, 1, 0, float(max_alt)],
        aspect="auto",
        cmap=cmap,
        norm=tax_norm,
        interpolation="bilinear",
    )

    # ------------------------------------------------------------------
    # 4. Contour lines for iso-tax levels
    # ------------------------------------------------------------------
    n_contours = 8
    contour = ax.contour(
        U, N, TAX,
        levels=n_contours,
        colors="white",
        linewidths=0.8,
        alpha=0.55,
    )
    ax.clabel(contour, fmt="T=%.2f", fontsize=7, inline=True, inline_spacing=4)

    # ------------------------------------------------------------------
    # 5. Scatter current assignment points
    # ------------------------------------------------------------------
    if points:
        pt_u      = [p[0] for p in points]
        pt_alt    = [p[1] for p in points]
        pt_tax    = [p[2] for p in points]
        ax.scatter(
            pt_u,
            pt_alt,
            c=pt_tax,
            cmap=cmap,
            norm=tax_norm,
            s=80,
            zorder=6,
            edgecolors="white",
            linewidths=1.0,
        )

    # ------------------------------------------------------------------
    # 6. Colorbar, labels, formatting
    # ------------------------------------------------------------------
    cbar = fig.colorbar(im, ax=ax, pad=0.02)
    cbar.set_label("Tax  =  α · u³ · (num_alternatives − 1)", fontsize=10)

    ax.set_xlabel("Resource utilization", fontsize=11)
    ax.set_ylabel("Number of alternatives", fontsize=11)
    ax.set_title(
        f"Tax heatmap over (utilization, alternatives) space\nα = {alpha},  max_additional_cost = {max_additional_cost}",
        fontsize=12,
    )

    plt.tight_layout()
    Path(output_path).parent.mkdir(parents=True, exist_ok=True)
    plt.savefig(output_path, dpi=150)
    plt.close(fig)
    print(f"Regret-rate heatmap saved to {output_path}")
    
