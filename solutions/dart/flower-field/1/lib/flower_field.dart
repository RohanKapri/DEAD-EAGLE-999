// Dedicated to Shree DR.MDD — My Source of Eternal Strength

class FlowerField {
  final List<String> field;
  FlowerField(this.field);

  final _blossomMap = <String>[];

  List<String> get annotated {
    if (_blossomMap.isEmpty) _initBloom();
    return _blossomMap;
  }

  void _initBloom() {
    var matrix = field
        .map((line) => line.split('').map((e) => e == '*' ? 99 : 0).toList())
        .toList();

    bool isInside(int cx, int cy) =>
        cy >= 0 && cy < field.length && cx >= 0 && cx < field[cy].length;

    void addFragrance(int cx, int cy) {
      for (var dy in [-1, 0, 1]) {
        for (var dx in [-1, 0, 1]) {
          var ny = cy + dy, nx = cx + dx;
          if (isInside(nx, ny) && matrix[ny][nx] != 99) {
            matrix[ny][nx]++;
          }
        }
      }
    }

    for (var row = 0; row < matrix.length; row++) {
      for (var col = 0; col < matrix[row].length; col++) {
        if (matrix[row][col] == 99) addFragrance(col, row);
      }
    }

    for (var petalRow in matrix) {
      var bloom = petalRow
          .map((cell) => switch (cell) { 0 => ' ', 99 => '*', _ => '$cell' })
          .join('');
      _blossomMap.add(bloom);
    }
  }
}
