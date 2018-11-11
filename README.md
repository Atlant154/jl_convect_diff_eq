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

When testing the execution speed, the following values are obtained:

|       Splits:       |     128    |     512    | 1'024      | 8'192     | 32'768    | 131'072    |
|:-------------------:|:----------:|:----------:|------------|-----------|-----------|------------|
| Julia(unoptimized): | 193.602 μs | 775.786 μs | 1.553 ms   | 13.377 ms | 62.039 ms | 493.350 ms |
| Julia(optimized):   | 23.035 μs  | 96.131 μs  | 215.877 μs | 3.078 ms  | 14.186 ms | 160.041 ms |
| Python(optimized):  | 18.916 ms  | 60.601 ms  | 123.002 ms | 1.088 sec | 3.879 sec | 15.206 sec |

Python code can be found [here](https://gist.github.com/Atlant154/f45ee4303fdc070ee3bb3907ae833191).
As you can see, the python code is almost two orders of magnitude slower.

## Visualization

Plotting is implemented using a PyPlot. It works correctly **only** when running from an external terminal.  
You can turn off the visualization by commenting out the relevant lines in the main.jl: 19 - 26.
