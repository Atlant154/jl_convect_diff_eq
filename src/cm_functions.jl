module CMFunc

export exact_solution, get_real_error, create_eq, get_h, get_tau

struct convect_eq
    x_left::Float32
    x_right::Float32
    t_left::Float32
    t_right::Float32
    h_num::Int
    tau_num::Int
    h
    tau
    a
    result
end

function get_h(x_left::Float32, x_right::Float32)

    println("Hello. Enter the number of splits: ")
    inputed_string = readline()
    h_num = parse(Int, inputed_string)
    h_candidate = (x_right - x_left) / h_num
    h = h_candidate > eps(Float32) ? h_candidate : eps(Float32)

    return (h_num, h)
end

function get_tau(t_left::Float32, t_right::Float32)

    println("Enter the number of time layers: ")
    inputed_string = readline()
    tau_num = parse(Int, inputed_string)
    tau_candidate = (t_right - t_left) / tau_num
    tau = tau_candidate > eps(Float32) ? tau_candidate : eps(Float32)

    return (tau_num, tau)
end

function create_eq()
    x_left::Float32 = 0.0
    x_right::Float32 = 1.0

    t_left::Float32 = 0.0
    t_right::Float32 = 1.0

    a::Float32 = 0.4
    (h_num, h) = CMFunc.get_h(x_left, x_right)
    (tau_num, tau) = CMFunc.get_tau(t_left, t_right)

    result_array = Array{Float32}(undef, tau_num, h_num)

    convection = convect_eq(x_left, x_right, t_left, t_right, h_num, tau_num, h, tau, a, result_array)

    return convection
end

function exact_solution(x, t)
    a::Float32 = 0.4
    return sin(2 * pi * (x - a * t)) + (x - a * t)^3
end

function get_real_error(convect::convect_eq)
    x_left::Float32 = 0.0
    t_left::Float32 = 0.0

    tl_num = convect.tau_num
    h_num = convect.h_num

    tau = convect.tau
    h = convect.h

    max_error::Float32 = 0.0

    for time_iter in 2:tl_num, space_iter in 2:h_num-1
        abs_exact = abs(exact_solution(x_left + (space_iter - 1) * h, t_left + (time_iter - 1) * tau))
        abs_apr = abs(convect.result[time_iter, space_iter])
        diff = abs(abs_exact - abs_apr)
        max_error = diff > max_error ? diff : max_error
    end

    return max_error
end

end  # moduleCMFunc
