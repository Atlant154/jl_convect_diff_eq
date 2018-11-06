# Numeric solution of convect equation. Lax–Friedrichs method

![logo](doc/logo.jpg)

## Requirements

1. [Julia](https://julialang.org/).
2. [PyPlot](https://github.com/JuliaPy/PyPlot.jl).

## How to run

1. Clone the repo: `git clone https://github.com/Atlant154/jl_convect_diff_eq.git`
2. Change `exact_solution` function in `src/cm_functions.jl`
3. Build the project: `make release`

## Visualization

Plotting is implemented using a PyPlot. It works correctly **only** when running from an external terminal.
