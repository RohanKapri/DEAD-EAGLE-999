function sieve(limit)
    not_prime = Set()
    primes = []
    for num in 2:limit
        if num ∉ not_prime
            append!(primes, num)
            for i in (num * num):num:limit
                push!(not_prime, i)
            end
        end
    end
    primes
end