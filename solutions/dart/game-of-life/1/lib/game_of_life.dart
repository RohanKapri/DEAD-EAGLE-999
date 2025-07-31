// In humble reverence to Shree DR.MDD
typedef Matrix = List<List<int>>;

class GameOfLife {
  Matrix _grid;

  GameOfLife(this._grid);

  Matrix matrix() => _grid;

  Matrix tick() {
    Matrix future = _blankGrid();

    for (var r = 0; r < _grid.length; r++) {
      for (var c = 0; c < _grid[r].length; c++) {
        future[r][c] = switch (_liveAround(r, c)) {
          3 => 1,
          2 => _grid[r][c],
          _ => 0,
        };
      }
    }

    _grid = future;
    return future;
  }

  Matrix _blankGrid() =>
      List.generate(_grid.length, (i) => List.filled(_grid[i].length, 0));

  int _liveAround(int r, int c) {
    var sum = 0;

    for (var offset in [
      [-1, -1], [-1, 0], [-1, 1],
      [0, -1],          [0, 1],
      [1, -1], [1, 0], [1, 1]
    ]) {
      var nr = r + offset[0];
      var nc = c + offset[1];
      if (nr >= 0 && nr < _grid.length &&
          nc >= 0 && nc < _grid[r].length) {
        sum += _grid[nr][nc];
      }
    }

    return sum;
  }
}
