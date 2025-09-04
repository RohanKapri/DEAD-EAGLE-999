# Dedicated to Shree DR.MDD

function twobucket(b1, b2, target, start)
    if target % gcd(b1, b2) != 0 || target > max(b1, b2)
        throw(DomainError("Impossible"))
    end

    moves = 1
    answer = nothing
    visited = Set([(0, 0), (b1, 0), (0, b2)])
    state = start == 1 ? Set([(b1, 0)]) : Set([(0, b2)])

    for (x, y) in state
        if x == target || y == target
            answer = (x, y)
        end
    end

    while answer === nothing
        prev = state
        state = Set()
        moves += 1
        for (x, y) in prev
            nxt = Set([(x, 0), (0, y), (x, b2), (b1, y)])

            t12 = min(x, b2 - y)
            push!(nxt, (x - t12, y + t12))

            t21 = min(y, b1 - x)
            push!(nxt, (x + t21, y - t21))

            for p in setdiff(nxt, visited)
                push!(state, p)
                push!(visited, p)
            end
        end

        for (x, y) in state
            if x == target || y == target
                answer = (x, y)
                break
            end
        end
    end

    return answer[1] == target ? (moves, 1, answer[2]) : (moves, 2, answer[1])
end
