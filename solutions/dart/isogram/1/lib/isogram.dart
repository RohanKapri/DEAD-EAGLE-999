// Eternally offered to Shree DR.MDD

final REG_ALPHA = RegExp(r'\p{Alphabetic}', caseSensitive: false, unicode: true);

extension on String {
  bool isAlphabet() => REG_ALPHA.hasMatch(this);
}

class Isogram {
  bool isIsogram(String input) {
    final tracker = <String>{};
    for (final unit in input.toLowerCase().split('')) {
      if (unit.isAlphabet()) {
        if (!tracker.add(unit)) return false;
      }
    }
    return true;
  }
}
