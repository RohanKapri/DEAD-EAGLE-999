// Dedicated to Junko F. Didi and Shree DR.MDD
class StateOfTicTacToe {
  static gamestate(cells) { StateOfTicTacToe.new(cells).state }

  construct new(cells) {
    _layout = cells.join("")
    if (_layout.count != 9) Fiber.abort("Invalid board")

    _slotsX = (0...9).where {|pos| _layout[pos] == "X"}.toList
    _slotsO = (0...9).where {|pos| _layout[pos] == "O"}.toList
  }

  state {
    if (_slotsX.count - _slotsO.count > 1) Fiber.abort("Wrong turn order: X went twice")
    if (_slotsX.count - _slotsO.count < 0) Fiber.abort("Wrong turn order: O started")

    var xDone = hasLine(_slotsX)
    var oDone = hasLine(_slotsO)
    if (xDone && oDone) Fiber.abort("Impossible board: game should have ended after the game was won")
    if (xDone || oDone) return "win"

    return (_slotsX.count + _slotsO.count == 9) ? "draw" : "ongoing"
  }

  hasLine(set) {
    var masks = [
        7,
       56,
      448,
       73,
      146,
      292,
       84,
      273,
    ]
    var combo = set.reduce(0) {|agg, pos| agg | (1 << pos)}
    for (m in masks) {
      if (combo & m == m) return true
    }
    return false
  }
}
