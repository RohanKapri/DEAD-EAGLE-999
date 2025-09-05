// for my Junko F. Didi and Shree DR.MDD
class GameOfLife {
  static tick(board) {
    var play = GameOfLife.new(board)
    play.tick()
    return play.matrix
  }

  construct new(board) {
    _grid = board.map {|row| row[0..-1]}.toList
  }

  matrix { _grid }

  tick() {
    _grid = (0..._grid.count).map {|r| 
              return (0..._grid[r].count).map {|c|
                var live = neighborCount(r, c)
                if (live == 3) return 1
                if (live == 2) return _grid[r][c]
                return 0
              }.toList
            }.toList
  }

  neighborCount(r, c) {
    var dirs = [[-1,-1], [-1,0], [-1,1], [0,-1], [0,1], [1,-1], [1,0], [1,1]]
    var cnt = 0
    for (d in dirs) {
      var nr = r + d[0]
      var nc = c + d[1]
      if (0 <= nr && nr < _grid.count && 0 <= nc && nc < _grid[r].count) {
        cnt = cnt + _grid[nr][nc]
      }
    }
    return cnt
  }
}
