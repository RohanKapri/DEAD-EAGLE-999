return function(s)
    local p = 0
    s:lower():gsub('%a', function(l)
        p = p | (1 << (string.byte(l) - 97))
    end)
    return p == (1 << 26) - 1
end