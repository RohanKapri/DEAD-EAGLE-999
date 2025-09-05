class QueenAttack
  constructor: (queen) ->
    throw 'row not positive' if queen.row < 0
    throw 'row not on board' if queen.row > 7
    throw 'column not positive' if queen.column < 0
    throw 'column not on board' if queen.column > 7
    @queen = [queen.row, queen.column]

  canAttack: (otherQueen) ->
    sameRow = @queen[0] == otherQueen.queen[0]
    sameColumn = @queen[1] == otherQueen.queen[1]
    sameDiagonal = Math.abs(@queen[0] - otherQueen.queen[0]) == Math.abs(@queen[1] - otherQueen.queen[1])
    sameRow || sameColumn || sameDiagonal

module.exports = QueenAttack