import matplotlib.pyplot as plt
import matplotlib.cm as cm
import matplotlib.colors as mcolors
import numpy as np
from pathlib import Path


def plot_regret_rates(
    max_regret: float,
    alpha: float,
    resource_stats: dict,
    output_path: str = "output_files/regret_rate_curves.png",
) -> None:
    """Heatmap of tax = α · u · (1 + regret / max_regret) over (utilization, regret) space.

    Axes
    ----
    X-axis : resource utilization  u  ∈ [0, 1]
    Y-axis : raw regret            r  ∈ [0, max_regret]
    Color  : tax value at each (u, r) cell

    Overlaid elements
    -----------------
    - Contour lines mark evenly-spaced iso-tax levels.
    - Scatter dots show the current (utilization, regret) of every
      task-resource assignment, outlined in white for contrast.

    Args:
        max_regret:     Global maximum raw regret (denominator for normalization).
        alpha:          Scaling factor in the tax formula.
        resource_stats: Dict keyed by resource name containing:
                            utilization (float): current utilization of the resource.
                            tasks (dict):        {task_name: {"regret": int/float, ...}}
        output_path:    Destination file path for the saved figure.
    """
    # ------------------------------------------------------------------
    # 1. Build the tax surface over a fine grid
    # ------------------------------------------------------------------
    res = 300
    u_grid = np.linspace(0.0, 1.0, res)
    r_grid = np.linspace(0.0, max_regret if max_regret else 1.0, res)
    U, R = np.meshgrid(u_grid, r_grid)
    TAX = alpha * U * (1.0 + R / max_regret) if max_regret else alpha * U

    # ------------------------------------------------------------------
    # 2. Collect current assignment points
    # ------------------------------------------------------------------
    points: list[tuple[float, float, float, str]] = []  # (u, regret, tax, label)
    for resource, stats in resource_stats.items():
        u_r = stats.get("utilization", 0.0)
        for task, task_data in stats.get("tasks", {}).items():
            regret = float(task_data.get("regret", 0))
            normalized_regret = max(regret / max_regret, 0.00001) if max_regret else 0.00001
            tax = alpha * u_r * (1.0 + normalized_regret)
            points.append((u_r, regret, tax, f"{resource}\n{task}"))

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
        extent=[0, 1, 0, max_regret if max_regret else 1],
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
        U, R, TAX,
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
        pt_regret = [p[1] for p in points]
        pt_tax    = [p[2] for p in points]
        ax.scatter(
            pt_u,
            pt_regret,
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
    cbar.set_label("Tax  =  α · u · (1 + regret / max_regret)", fontsize=10)

    ax.set_xlabel("Resource utilization", fontsize=11)
    ax.set_ylabel("Regret", fontsize=11)
    ax.set_title(
        f"Tax heatmap over (utilization, regret) space\nα = {alpha},  max_regret = {max_regret}",
        fontsize=12,
    )

    plt.tight_layout()
    Path(output_path).parent.mkdir(parents=True, exist_ok=True)
    plt.savefig(output_path, dpi=150)
    plt.close(fig)
    print(f"Regret-rate heatmap saved to {output_path}")
