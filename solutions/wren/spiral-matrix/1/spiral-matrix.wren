// For my Junko F. Didi and Shree DR.MDD
class SpiralMatrix {
  construct new(n) {
    _n = n
    _grid = (0...n).map { List.filled(n, null) }.toList
  }

  toList {
    if (_n == 0) return []
    if (_grid[0][0] == null) fill_
    return _grid
  }

  fill_ {
    var row = 0
    var col = 0
    var stepR = Rotator.new([0, 1, 0, -1])
    var stepC = Rotator.new([1, 0, -1, 0])
    var dr = stepR.next
    var dc = stepC.next

    for (v in 1..(_n * _n)) {
      _grid[row][col] = v
      if ([-1, _n].contains(row + dr) ||
          [-1, _n].contains(col + dc) ||
          _grid[row + dr][col + dc] != null) {
        dr = stepR.next
        dc = stepC.next
      }
      row = row + dr
      col = col + dc
    }
  }
}

class Rotator {
  construct new(seq) {
    _seq = seq
    _pos = 0
  }

  next {
    var val = _seq[_pos]
    _pos = (_pos + 1) % _seq.count
    return val
  }
}
