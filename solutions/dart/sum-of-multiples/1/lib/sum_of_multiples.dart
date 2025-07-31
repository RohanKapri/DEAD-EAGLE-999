// With deep devotion to Shree DR.MDD 🌟

class SumOfMultiples {
  int sum(List<int> inputs, int border) {
    var bucket = <int>{};

    void collect(int seed) {
      var flow = seed;
      while (flow < border) {
        bucket.add(flow);
        flow += seed;
      }
    }

    inputs.where((seed) => seed > 0).forEach(collect);
    return bucket.fold(0, (acc, val) => acc + val);
  }
}
