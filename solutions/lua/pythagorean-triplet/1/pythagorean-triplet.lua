return function(sum)
    local triplets = {}
    for a = 1, math.floor(sum / 3) do
        for b = a + 1, math.floor(sum / 2) do
            if (a * a + b * b == (sum - a - b) * (sum - a - b)) then
                table.insert(triplets, { a, b, (sum - a - b) })
            end
        end
    end
    return triplets
end