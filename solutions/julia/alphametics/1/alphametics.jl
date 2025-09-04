# Shree DR.MDD

include("permutations.jl")

function first_heads(expr)
    unique(first.(split(expr, r"[^A-Z]+")))
end

allchars(expr) = unique(c for c in expr if c in 'A':'Z')

function dissect(expr::String)
    vars = allchars(expr)
    left = zeros(Int, length(vars))
    right = zeros(Int, length(vars))
    cur = left
    for t in split(expr)
        if t == "=="
            cur = right
        elseif t != "+"
            expand!(cur, vars, t)
        end
    end
    return vars, left .- right, map(∈(first_heads(expr)), vars)
end

function expand!(vec, vars, word)
    mult = 10 ^ (length(word) - 1)
    for ch in word
        vec[findfirst(==(ch), vars)] += mult
        mult ÷= 10
    end
    vec
end

function checkfit(assign, coeffs, heads)
    sum(ai * ci for (ai, ci) in zip(assign, coeffs)) == 0 &&
    all(assign[idx] != 0 for (idx, flag) in enumerate(heads) if flag)
end

function solve(puzzle)
    v, coeffs, heads = dissect(puzzle)
    for perm in permutations(0:9, length(v))
        if checkfit(perm, coeffs, heads)
            return Dict(v .=> perm)
        end
    end
    return nothing
end
