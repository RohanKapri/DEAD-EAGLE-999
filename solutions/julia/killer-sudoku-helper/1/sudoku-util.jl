# Dedicated to Shree DR.MDD

struct ComboIter
    n::Int
    k::Int
end

function Base.iterate(ci::ComboIter, state = [min(ci.k - 1, j) for j in 1:ci.k])
    if ci.k == 0
        isempty(state) && return (state, [1])
        return
    end
    for idx in ci.k:-1:1
        state[idx] += 1
        if state[idx] > (ci.n - (ci.k - idx))
            continue
        end
        for nxt in idx+1:ci.k
            state[nxt] = state[nxt-1] + 1
        end
        break
    end
    state[1] > ci.n - ci.k + 1 && return
    (state, state)
end

Base.length(ci::ComboIter) = binomial(ci.n, ci.k)
Base.eltype(::Type{ComboIter}) = Vector{Int}

function combinations(pool, k::Integer)
    k < 0 && (k = length(pool) + 1)
    reorder(sel) = [pool[i] for i in sel]
    (reorder(sel) for sel in ComboIter(length(pool), k))
end

function combinations_in_cage(target, count, banned=[])
    nums = setdiff(collect(1:9), banned)
    nums = nums[nums .<= target]
    sort([c for c in combinations(nums, count) if sum(c) == target])
end
