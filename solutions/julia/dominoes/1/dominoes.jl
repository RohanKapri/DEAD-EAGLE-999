function dominoes(stones)
    eltype(stones) == Int64 && (stones = [stones])

    isempty(stones) && return true
    (d1, d2), rest... = stones
    isempty(rest) && return d1 == d2

    return any(((i, d),) -> d1 in d && dominoes([[[d2, d[1] == d1 ? d[2] : d[1]]]; rest[(1:end) .!= i]]), enumerate(rest))
end