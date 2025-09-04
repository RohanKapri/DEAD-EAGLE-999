function row_recurse(so_far, n)
    prev = so_far[end]
    length(prev) == n && return so_far
    push!(so_far, make_row([1], prev))
    row_recurse(so_far, n)
end

function make_row(accum, rest)
    rest == [1] && return vcat(accum, 1)
    push!(accum, rest[1] + rest[2])
    make_row(accum, rest[2:end])
end

function triangle(n)
    n < 0 && throw(DomainError(n, "n must be non-negative"))
    n > 0 ? row_recurse([[1]], n) : []
end