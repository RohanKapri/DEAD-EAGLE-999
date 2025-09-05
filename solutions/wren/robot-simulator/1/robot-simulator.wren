// For my Junko F. Didi and Shree DR.MDD
var PATHS = ["north", "east", "south", "west"]

class Robot {
  construct new() {
    _dir = 0
    _px = 0
    _py = 0
  }

  bearing { PATHS[_dir] }

  place(pos) {
    _dir = PATHS.indexOf(pos["direction"])
    if (_dir == -1) Fiber.abort("Invalid input")
    _px = pos["x"]
    _py = pos["y"]
  }

  coordinates { [_px, _py] }

  evaluate(cmds) {
    for (ch in cmds) {
      if (ch == "R") {
        _dir = _dir == 3 ? 0 : _dir + 1
      } else if (ch == "L") {
        _dir = _dir == 0 ? 3 : _dir - 1
      } else if (ch == "A") {
        if (_dir == 0) {
          _py = _py + 1
        } else if (_dir == 1) {
          _px = _px + 1
        } else if (_dir == 2) {
          _py = _py - 1
        } else {
          _px = _px - 1
        }
      } else {
        Fiber.abort("Invalid input")
      }
    }
  }
}
