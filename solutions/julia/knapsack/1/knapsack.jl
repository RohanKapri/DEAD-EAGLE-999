function maximum_value(maxw, items)
    memo = zeros(Int, (length(items)+1, maxw+1))
    for j in 0:maxw, i in 1:length(items)
        memo[i+1, j+1] = items[i].weight > j ? memo[i, j+1] : max(memo[i, j+1], memo[i, j+1-items[i].weight] + items[i].value)
    end
    maximum(memo)
end