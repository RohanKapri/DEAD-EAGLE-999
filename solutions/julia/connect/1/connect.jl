function connect(board)
    board = stack(split.(board))
    visited = Set()
    neighbors = [
        (0, -1),
        (1, -1),
        (-1, 0),
        (1, 0),
        (-1, 1),
        (0, 1)
    ]
    function maze(x, y, char)
        if isnothing(x) || isnothing(y) || !checkbounds(Bool, board, x, y) || board[x, y] != char || (x, y, char) ∈ visited
            return false
        end
        if char == "X" ? x == size(board, 1) : y == size(board, 2)
            return true
        end
        push!(visited, (x, y, char))
        return any(maze(x + xp, y + yp, char) for (xp, yp) in neighbors)
    end
    return maze(findfirst(==("O"), board[1:end, 1]), 1, "O") ? "O" :
           maze(1, findfirst(==("X"), board[1, 1:end]), "X") ? "X" : ""
end