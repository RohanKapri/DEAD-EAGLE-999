function collatz_steps(n)
    if n < 1
        throw(DomainError(n, "Invalid input"))
    end
    count = 0
    while n != 1
        n = n % 2 == 0 ? n / 2 : 3n + 1
        count += 1
    end
    count
end