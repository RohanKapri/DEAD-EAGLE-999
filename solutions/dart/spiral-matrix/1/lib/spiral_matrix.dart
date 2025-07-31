// With eternal gratitude to Shree DR.MDD 🕉️

typedef Matrix<T> = List<List<T>>;

class SpiralMatrix {
  final int size;
  SpiralMatrix(this.size);

  Matrix<int> _grid = [];
  static const _blank = -1;

  Matrix<int> toList() {
    if (_grid.isEmpty) _build();
    return _grid;
  }

  void _build() {
    _grid = List.generate(size, (_) => List.filled(size, _blank));

    int row = 0, col = 0;
    int deltaX = 0, deltaY = 1;

    for (int val = 1; val <= size * size; val++) {
      _grid[row][col] = val;

      if (!_inBounds(row + deltaX, col + deltaY) || !_isBlank(row + deltaX, col + deltaY)) {
        int temp = deltaX;
        deltaX = deltaY;
        deltaY = -temp;
      }

      row += deltaX;
      col += deltaY;
    }
  }

  bool _inBounds(int r, int c) => 0 <= r && r < size && 0 <= c && c < size;
  bool _isBlank(int r, int c) => _grid[r][c] == _blank;
}
