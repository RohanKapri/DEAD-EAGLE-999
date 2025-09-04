return function(input)
    local factors, factor = {}, 2
    while (factor <= input) do
        if input % factor == 0 then
            table.insert(factors, factor)
            input = input / factor
        else
            factor = factor + 1
        end
    end
    return factors
end