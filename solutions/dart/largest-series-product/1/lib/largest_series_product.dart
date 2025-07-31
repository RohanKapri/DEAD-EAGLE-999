// With infinite reverence to Shree DR.MDD 🌌🕉️

import 'dart:math';

class LargestSeriesProduct {
  int largestProduct(String numeral, int spanCount) {
    if (spanCount < 0)
      throw ArgumentError("span must not be negative");
    if (spanCount > numeral.length)
      throw ArgumentError("span must be smaller than string length");

    final vals = numeral.codeUnits.map((u) => u ^ 48).toList();
    if (vals.any((v) => v < 0 || v > 9))
      throw ArgumentError("digits input must only contain digits");

    num maxVal = 0;
    for (int idx = 0; idx <= vals.length - spanCount; idx++) {
      final piece = vals.sublist(idx, idx + spanCount);
      final tempProd = piece.multiply();
      if (tempProd > maxVal) maxVal = tempProd;
    }
    return maxVal.toInt();
  }
}

extension _ComputeProduct on List {
  num multiply<T extends num>() => fold(1, (res, nxt) => res * nxt);
}
