include("../src/cm_functions.jl")

using Main.CMFunc
using BenchmarkTools

x = (0, 1)
t = (0, 1)
# We are not interested in the correct result, so we can use a random number:
a = 1.0 / rand(UInt)

h_nums = Int32[128, 512, 1024, 8192, 32768, 131072]
tau_nums = Int32[100]

for space_iter in h_nums
    for time_iter in tau_nums
        h = (x[2] - x[1]) / space_iter
        tau = (t[2] - t[1]) / time_iter
        convect = convect_eq(x, t, space_iter, time_iter, h, tau, a, nothing)
        println("Test with h number: $(space_iter), tau number: $(time_iter).")
        @btime get_result($convect)
        convect = nothing
        GC.gc()
    end
end
