module LaxFri

export get_new_time_layer

function get_new_time_layer(timeline, n, h, tau, a)
    new_timeline = Array{Float32}(undef, n)

    @simd for iter in 2:n-1
        new_timeline[iter] = 0.5 * (timeline[iter + 1] + timeline[iter - 1]) - a * (tau / (2 * h)) * (timeline[iter + 1] - timeline[iter - 1])
    end
    return new_timeline
end

end
