include("src/cm_functions.jl")

using Main.CMFunc
using PyPlot
using BenchmarkTools

# Creating equation structure:
convect = create_eq()

# Geting matrix of approximate solution:
convect = get_result(convect)

# Finding real error of approximation:
max_error =  get_real_error(convect)

# Printing the error:
println("Maximum error is $(max_error).")

# Geting 0x abd 0y arrays:
h_arr = range(convect.x_left, stop=convect.x_right, length=convect.h_num)
tau_arr = range(convect.t_left, stop=convect.t_right, length=convect.tau_num)

# Ploting the surface of approxiamte solution:
surf(h_arr, tau_arr, convect.result, cmap="coolwarm")
title("Convect equation. Lax–Friedrichs method. H-nodes: $(convect.h_num). Tau-nodes: $(convect.tau_num).")
show()
