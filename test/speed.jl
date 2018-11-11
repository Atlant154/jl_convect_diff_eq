include("../src/cm_functions.jl")

using Main.CMFunc
using BenchmarkTools

x = (0, 1)
t = (0, 1)
# Magick number:
a = 0.4

h_nums = Int32[500, 1000, 2000, 10000]
tau_nums = copy(h_nums)

for space_iter in h_nums
    for time_iter in tau_nums
        h = (x[2] - x[1]) / space_iter
        tau = (t[2] - t[1]) / time_iter
        result_array = Array{Float32}(undef, time_iter, space_iter)
        convect = convect_eq(x[1], x[2], t[1], t[2], space_iter, time_iter, h, tau, 0.4, result_array)
        println("Test with h number: $(space_iter), tau number: $(time_iter).")
        @btime get_result($convect)
        convect = nothing
        GC.gc()
    end
end
