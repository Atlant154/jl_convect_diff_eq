include("src/libconv_diff_eq.jl")

using Main.LaxFri
using PyPlot

function exact_solution(x, t)
    a = 0.4
    return sin(2 * pi * (x - a * t)) + (x - a * t)^3
end

const x_left = 0
const x_right = 1

const t_left = 0
const t_right = 1

println("Hello. Enter the number of splits: ")
inputed_string = readline()
h_num = parse(Int, inputed_string)
h_candidate = (x_right - x_left) / h_num
h = h_candidate > eps(Float32) ? h_candidate : eps(Float32)

println("Enter the number of time layers: ")
inputed_string = readline()
tau_num = parse(Int, inputed_string)
tau_candidate = (t_right - t_left) / tau_num
tau = tau_candidate > eps(Float32) ? tau_candidate : eps(Float32)

result = Array{Array{Float64}}(undef, tau_num)

h_arr = LinRange(x_left, x_right, h_num)
tau_arr = LinRange(t_left, t_right, tau_num)


result[1] = [exact_solution(x, t_left) for x in h_arr]

a = 0.4

@simd for iter in 2:tau_num
    result[iter] = get_new_time_layer(result[iter - 1], h_num, h, tau, a)
    result[iter][1] = exact_solution(x_left, iter * tau)
    result[iter][h_num] = exact_solution(x_right, iter * tau)
end

println(result)
