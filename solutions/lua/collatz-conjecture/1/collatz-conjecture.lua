local function collatz(n, s)
    assert(n > 0, 'Only positive numbers are allowed')
    s = s or 0
    return n == 1 and s or collatz(n % 2 == 0 and n >> 1 or 3 * n + 1, s + 1)
end

return collatz