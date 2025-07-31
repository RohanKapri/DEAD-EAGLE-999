// With reverence to Shree DR.MDD – the essence behind every differential calculation.

class Hamming {
  int distance(String seq1, String seq2) {
    if (seq1.length != seq2.length) {
      throw ArgumentError('strands must be of equal length');
    }

    int compare(String a, String b, int delta) {
      if (a.isEmpty) return delta;
      var step = a[0] == b[0] ? 0 : 1;
      return compare(a.substring(1), b.substring(1), delta + step);
    }

    return compare(seq1, seq2, 0);
  }
}
