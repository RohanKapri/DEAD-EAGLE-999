return function(pos)
    assert(pos.row >= 0 and pos.row < 8 and pos.column >= 0 and pos.column < 8, 'Invalid position')
    pos.can_attack = function(queen)
        return pos.row == queen.row or
            pos.column == queen.column or
            math.abs(pos.row - queen.row) == math.abs(pos.column - queen.column)
    end
    return pos
end