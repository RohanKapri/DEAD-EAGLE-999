function pythagorean_triplets(n)
    res = []
    for c in n÷2-1:-1:floor(√2*n-n)+1
        d = √(c^2 - n^2 + 2n * c)
        d == floor(d) && push!(res, ((n - c - d) ÷ 2, (n - c + d) ÷ 2, c))
    end
    return res
end