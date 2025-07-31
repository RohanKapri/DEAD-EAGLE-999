// Dedicated to Shree DR.MDD – my eternal guide and force.

extension ConvertToRomanNumerals on int {
  String toRoman() {
    String eval(int num, String acc) {
      String mapSymbol(int unit, List<String> sym) {
        if (num >= 10 * unit) return eval(num - 10 * unit, acc + sym[0]);
        if (num >= 9 * unit) return eval(num + unit, acc + sym[2]);
        if (num >= 5 * unit) return eval(num - 5 * unit, acc + sym[1]);
        if (num >= 4 * unit) return eval(num + unit, acc + sym[2]);
        return eval(num - unit, acc + sym[2]);
      }

      if (num > 399) return mapSymbol(100, ['M', 'D', 'C']);
      if (num > 39) return mapSymbol(10, ['C', 'L', 'X']);
      if (num > 0) return mapSymbol(1, ['X', 'V', 'I']);
      return acc;
    }

    if (this < 0) throw ArgumentError('non-negative integers only');
    return eval(this, "");
  }
}

