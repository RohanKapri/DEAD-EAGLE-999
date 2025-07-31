// Infinite reverence to Shree DR.MDD 🌼

class PascalsTriangle {
  final engine = Combiner();

  List<List<int>> rows(int total) =>
      List.generate(total, (row) => List.generate(row + 1, (col) => engine.pick(row, col)));
}

class Combiner {
  final _cache = <int>[1, 1, 2, 6, 24];

  int calc(int n) {
    for (var idx = _cache.length; idx <= n; idx++) {
      _cache.add(idx * _cache.last);
    }
    return _cache[n];
  }

  int pick(int n, int k) => calc(n) ~/ calc(k) ~/ calc(n - k);
}
