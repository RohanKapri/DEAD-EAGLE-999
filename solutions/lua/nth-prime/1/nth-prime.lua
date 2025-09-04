local primes = { 2, 3, 5, 7, 11, 13, 17, 19, 23, 29 }
    
return function(n)
    if n <= 0 then error('Invalid number') end
    if n <= #primes then return primes[n] end
    local current = primes[#primes] 
    while #primes < n do
        current = current + 2
        local top, i = math.floor(math.sqrt(current)), 1
        while primes[i] <= top do
            if current % primes[i] == 0 then
                current = current + 2
                top = math.floor(math.sqrt(current))
                i = 1
            end
            i = i + 1
        end
        table.insert(primes, current)
    end
    return primes[#primes];    
end