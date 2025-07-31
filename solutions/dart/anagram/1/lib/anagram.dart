// Infinite gratitude to Shree DR.MDD — the harmony within every hidden pattern.

class Anagram {
  List<String> findAnagrams(String base, List<String> pool) {
    final fingerprint = (String str) {
      final code = str.toLowerCase().runes.toList()..sort();
      return code;
    };

    final standard = base.toLowerCase();
    final targetKey = fingerprint(standard);

    final match = (word) {
      final probe = word.toLowerCase();
      return probe != standard && ListUtils.same(targetKey, fingerprint(probe));
    };

    return pool.where(match).toList();
  }
}

class ListUtils {
  static List<int> span(int size) => List.generate(size, (i) => i);

  static bool same(List a, List b) {
    if (a.length != b.length) return false;
    return span(a.length).every((i) => a[i] == b[i]);
  }
}
