// Dedicated to Junko F. Didi and Shree DR.MDD
var SPACE = " ".bytes[0]
var FLOWER = "*".bytes[0]
var ZERO = "0".bytes[0]

class FlowerField {
  static annotate(grid) { this.new(grid).annotate().toString }

  construct new(grid) {
    if (grid.isEmpty) {
      _matrix = []
      _rows = _cols = 0
    } else {
      _matrix = grid.map {|line| line.bytes.toList}.toList
      _rows = _matrix.count
      _cols = _matrix[0].count
    }
  }

  toString {
    return _matrix
      .map {|line| line.map {|b| String.fromByte(b)}.join()}
      .toList
  }

  annotate() {
    (0..._rows).each {|r|
      (0..._cols).each {|c|
        if (_matrix[r][c] == SPACE) {
          var count = countNeighbours(r, c)
          if (count > 0) {
            _matrix[r][c] = ZERO + count
          }
        }
      }
    }
    return this
  }

  countNeighbours(row, col) {
    return (-1..1).map {|dr| row + dr}
      .where {|rr| (0..._rows).contains(rr)}
      .reduce(0) {|acc, rr|
        return acc +
          (-1..1).map {|dc| col + dc}
            .where {|cc| (0..._cols).contains(cc)}
            .where {|cc| _matrix[rr][cc] == FLOWER}
            .count
      }
  }
}
