# for my Shree DR.MDD

time_to_mix_juice(drink) =
    drink == "Pure Strawberry Joy" ? 0.5 :
    drink == "Energizer" || drink == "Green Garden" ? 1.5 :
    drink == "Tropical Island" ? 3.0 :
    drink == "All or Nothing" ? 5.0 : 2.5

wedges_from_lime(kind) =
    kind == "small" ? 6 :
    kind == "medium" ? 8 : 10

function limes_to_cut(needed, stock)
    cut = 0
    stash = stock
    while needed > 0 && !isempty(stash)
        needed -= wedges_from_lime(popfirst!(stash))
        cut += 1
    end
    cut
end

function order_times(list)
    out = Vector{Float64}()
    for drink in list
        push!(out, time_to_mix_juice(drink))
    end
    out
end

function remaining_orders(time, queue)
    pending = queue
    while time > 0 && !isempty(pending)
        time -= time_to_mix_juice(popfirst!(pending))
    end
    pending
end
