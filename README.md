# Numeric solution of convect equation. Lax–Friedrichs method

![logo](doc/logo.jpg)

## Requirements

1. [Julia](https://julialang.org/) - required for calculations.
2. [PyPlot](https://github.com/JuliaPy/PyPlot.jl) - required for visualization.
3. Python [matploitlib](https://matplotlib.org/) - PyPlot dependence.

PyPlot can be installing using `make deps_install`.

## How to run

### Computation

1. Clone the repo: `git clone https://github.com/Atlant154/jl_convect_diff_eq.git`
2. Change `exact_solution` function in `src/cm_functions.jl`
3. Build the project: `make`, `make debug` or `make release`

### Speed test

1. Clone the repo: `git clone https://github.com/Atlant154/jl_convect_diff_eq.git`
2. Change `exact_solution` function in `src/cm_functions.jl`
3. Start speed test: `make speed_test`

## Visualization

Plotting is implemented using a PyPlot. It works correctly **only** when running from an external terminal.  
You can turn off the visualization by commenting out the relevant lines in the main.jl: 19 - 26.
