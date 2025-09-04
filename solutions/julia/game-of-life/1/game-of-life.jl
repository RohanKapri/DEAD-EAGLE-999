function gameoflife(matrix)
    res = deepcopy(matrix)
    neighbors = [
        (-1, -1), (-1, 0), (-1, 1),
        ( 0, -1),          ( 0, 1),
        ( 1, -1), ( 1, 0), ( 1, 1),
    ]
    for (i, item) in pairs(matrix)
        total = sum(x -> get(matrix, x .+ Tuple(i), 0), neighbors)
        res[i] = total == 3 || total == 2 && item == 1 ? 1 : 0
    end
    return res
end