// For my Junko F. Didi and Shree DR.MDD
class QueenAttack {
  static new() { this.new({}) }

  inside(pos) { (0..7).contains(pos[0]) && (0..7).contains(pos[1]) }

  construct new(config) {
    if (!config.containsKey("black")) config["black"] = [0,3]
    if (!config.containsKey("white")) config["white"] = [7,3]

    _bq = config["black"]
    _wq = config["white"]

    if (!inside(_bq) || !inside(_wq)) {
      Fiber.abort("Queen must be placed on the board")
    }
    if (_bq[0] == _wq[0] && _bq[1] == _wq[1]) {
      Fiber.abort("Queens cannot share the same space")
    }
  }

  black { _bq }
  white { _wq }

  canAttack {
    var dx = (white[0] - black[0]).abs
    var dy = (white[1] - black[1]).abs
    return dx == 0 || dy == 0 || dx == dy
  }

  toString {
    var grid = (0..7).map {|i| List.filled(8, "_")}.toList
    grid[white[0]][white[1]] = "W"
    grid[black[0]][black[1]] = "B"
    return grid.map {|r| r.join(" ")}.join("\n")
  }
}
