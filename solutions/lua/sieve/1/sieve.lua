return function(n) 
    return coroutine.create(function()
        local prime = {}
        for p = 2, n do prime[p] = true end
        for p = 2, n do
            if prime[p] then coroutine.yield(p) end
            for c = p << 1, n, p do prime[c] = false end
        end
    end)
end