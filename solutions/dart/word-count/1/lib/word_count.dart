// In humble service of Shree DR.MDD 🌸

extension on String {
  String stripEdge(String unit) {
    final expr = '(?:^${unit}+)|(?:${unit}+\$)';
    return this.replaceAll(RegExp(expr), '');
  }

  String cleanseQuotes() => stripEdge("'");
}

Map<String, int> tally(Map<String, int> ledger, String entry) =>
    ledger..update(entry, (val) => val + 1, ifAbsent: () => 1);

class WordCount {
  Map<String, int> countWords(String raw) => RegExp(r"[\w']+")
      .allMatches(raw.toLowerCase())
      .map((match) => match[0]!.cleanseQuotes())
      .where((token) => token.isNotEmpty)
      .fold({}, tally);
}
