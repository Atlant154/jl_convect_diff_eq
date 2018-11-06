include("src/cm_functions.jl")

using Main.CMFunc
using PyCall
using PyPlot

convect = create_eq()

h_arr = range(convect.x_left, stop=convect.x_right, length=convect.h_num)
tau_arr = range(convect.t_left, stop=convect.t_right, length=convect.tau_num)

@simd for iter in 1:convect.h_num
    convect.result[1, iter] = exact_solution(convect.x_left + (iter - 1) * convect.h, convect.t_left)
end

@simd for iter in 2:convect.tau_num
    for opr_iter in 2:convect.h_num-1
        convect.result[iter, opr_iter] = (0.5 * (convect.result[iter - 1, opr_iter + 1]
            + convect.result[iter - 1, opr_iter - 1]) - convect.a * (convect.tau / (2 * convect.h))
            * (convect.result[iter - 1, opr_iter + 1] - convect.result[iter - 1, opr_iter - 1]))
    end
    convect.result[iter, 1] = exact_solution(convect.x_left, (iter - 1) * convect.tau)
    convect.result[iter, convect.h_num] = exact_solution(convect.x_right, iter * convect.tau)
end

max_error = get_real_error(convect)

println("Maximum error is: $(max_error)")

surf(h_arr, tau_arr, convect.result, cmap="jet")
title("Convect equation. Lax–Friedrichs method. H-nodes: $(convect.h_num). Tau-nodes: $(convect.tau_num).")
show()
