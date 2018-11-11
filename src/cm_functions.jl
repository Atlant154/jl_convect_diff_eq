__precompile__()

module CMFunc

export exact_solution, get_real_error
export create_eq, get_h, get_tau
export get_result
export convect_eq

mutable struct convect_eq
    x_range::Tuple{Float32, Float32}
    t_range::Tuple{Float32, Float32}
    h_num::UInt32
    tau_num::UInt32
    h::Float32
    tau::Float32
    a::Float32
    result
end

function get_h(x_range::Tuple{Float32, Float32})

    println("Hello. Enter the number of splits: ")
    inputed_string = readline()
    h_num = parse(UInt32, inputed_string)
    h_candidate = (x_range[2] - x_range[1]) / h_num
    h::Float32 = h_candidate > eps(Float32) ? h_candidate : eps(Float32)

    return (h_num, h)
end

function get_tau(t_range::Tuple{Float32, Float32})

    println("Enter the number of time layers: ")
    inputed_string = readline()
    tau_num = parse(UInt32, inputed_string)
    tau_candidate = (t_range[2] - t_range[1]) / tau_num
    tau::Float32 = tau_candidate > eps(Float32) ? tau_candidate : eps(Float32)

    return (tau_num, tau)
end

function create_eq()
    # Traditional bounds. Change if necessary!
    # Space bounds:
    x_range = (Float32(0.0), Float32(1.0))
    # Time bounds:
    t_range = (Float32(0.0), Float32(1.0))

    # Achtung! Hardcoded constand:
    a::Float32 = 0.4

    (h_num, h) = CMFunc.get_h(x_range)
    (tau_num, tau) = CMFunc.get_tau(t_range)

    # Creating the solution array:
    result_array = Array{Float32}(undef, tau_num, h_num)

    # Construction of equation structure:
    convection = convect_eq(x_range, t_range, h_num, tau_num, h, tau, a, result_array)

    return convection
end

# Depends on the task. Change if necessary:
function exact_solution(x, t)
    a::Float32 = 0.4
    return sin(2 * pi * (x - a * t)) + (x - a * t)^3
end

function get_result(convect::convect_eq)
    x_left = convect.x_range[1]
    x_right = convect.x_range[2]
    t_left = convect.t_range[1]

    tau_num = convect.tau_num
    h_num = convect.h_num

    h = convect.h
    tau = convect.tau
    a = convect.a

    result = Array{Float32}(undef, tau_num, h_num)

    for iter in 1:h_num
        result[1, iter] = exact_solution(x_left + (iter - 1) * h, t_left)
    end

    for iter in 2:tau_num
        @simd for opr_iter in 2:h_num-1
            result[iter, opr_iter] = (0.5 * (result[iter - 1, opr_iter + 1]
                + result[iter - 1, opr_iter - 1]) - a * (tau / (2 * h))
                * (result[iter - 1, opr_iter + 1] - result[iter - 1, opr_iter - 1]))
        end
        result[iter, 1] = exact_solution(x_left, (iter - 1) * tau)
        result[iter, h_num] = exact_solution(x_right, iter * tau)
    end

    convect.result = result

    return convect
end

function get_real_error(convect::convect_eq)
    x_left = convect.x_range[1]
    t_left = convect.t_range[1]

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
