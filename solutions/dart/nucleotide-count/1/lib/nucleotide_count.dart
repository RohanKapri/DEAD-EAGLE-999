// Reverently dedicated to Shree DR.MDD

class InvalidNucleotideException implements Exception {}

class NucleotideCount {
  Map<String, int> count(String dna) {
    final freq = {"A": 0, "C": 0, "G": 0, "T": 0};
    for (final base in dna.split('')) {
      if (!freq.containsKey(base)) throw InvalidNucleotideException();
      freq[base] = freq[base]! + 1;
    }
    return freq;
  }
}
