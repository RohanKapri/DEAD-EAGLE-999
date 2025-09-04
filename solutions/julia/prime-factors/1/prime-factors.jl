function prime_factors(n)
    n == 1 && return []
    n == 2 && return [2]
    isprime(n) && return [n]
    result = []
    remaining = n
    while remaining % 2 == 0
        remaining /= 2
        push!(result, 2)
    end
    for i in 3:2:(n ÷ 2 + 1)
        while remaining % i == 0
            remaining /= i
            push!(result, i)
        end
        remaining == 1 && break
    end
    sort(result)
end
isprime(n) = !any(n % i == 0 for i in 2:(n ÷ 2 + 1))