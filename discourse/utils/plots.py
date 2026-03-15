'''
Author(s): Craig Fouts
Correspondence: c.fouts25@imperial.ac.uk
License: Apache 2.0 license
'''

import matplotlib.pyplot as plt

__all__ = [
    'scatter'
]

def scatter(x, y, s=100, c=None, marker='o', fig_size=(6, 4), title=None, x_label=None, y_label=None, x_ticks=None, y_ticks=None, grid_alpha=.5, return_plot=False):
    fig, ax = plt.subplots(figsize=fig_size)
    ax.grid(alpha=grid_alpha)
    ax.scatter(x, y, s=100, c=c, marker=marker, zorder=2)
    ax.set(title=title, xlabel=x_label, ylabel=y_label)
    plt.xticks(x_ticks)
    plt.yticks(y_ticks)
    fig.tight_layout()

    if return_plot:
        plt.close()

        return fig, ax
