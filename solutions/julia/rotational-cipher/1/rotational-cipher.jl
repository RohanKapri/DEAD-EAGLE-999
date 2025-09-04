function convchar(c, n)
    lcase = collect('a':'z')
    ucase = collect('A':'Z')
    initial = vcat(lcase, ucase)
    final = vcat(lcase[n+1:end], lcase[1:n], ucase[n+1:end], ucase[1:n])
    inx = indexin(c, initial)[1]
    if (inx == nothing)
        return c
    end
    return final[inx]
end
function rotate(n, input)
    n = n%26
    if (n in([0, 26]))
        return input
    end
    if (input isa Char) 
        return convchar(input, n)
    end
    map(c->convchar(c, n), input)
end