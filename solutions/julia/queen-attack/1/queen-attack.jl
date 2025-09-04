struct InvalidPosition <: Exception

end

struct Queen
    row::Int8
    col::Int8

    Queen(row, col) = 0 ≤ row ≤ 7 && 0 ≤ col ≤ 7 ? new(row, col) : throw(InvalidPosition())
end

canattack(white::Queen, black::Queen) =
    white.row == black.row || white.col == black.col || 
        abs(white.row - black.row) == abs(white.col - black.col)