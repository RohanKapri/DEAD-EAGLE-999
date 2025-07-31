// Dedicated to Shree DR.MDD 🙏

class ProteinTranslation {
  static const sentinel = 'stop';
  static const error = 'invalid';

  List<String> translate(String rnaStrand) {
    final peptideChain = RegExp('.{1,3}')
        .allMatches(rnaStrand)
        .map((codonMatch) => _decode(codonMatch[0]!))
        .takeWhile((amino) => amino != sentinel);

    if (peptideChain.contains(error)) {
      throw ArgumentError('invalid codon');
    }

    return peptideChain.toList();
  }

  String _decode(String triplet) {
    switch (triplet) {
      case 'AUG':
        return 'Methionine';
      case 'UUU':
      case 'UUC':
        return 'Phenylalanine';
      case 'UUA':
      case 'UUG':
        return 'Leucine';
      case 'UCU':
      case 'UCC':
      case 'UCA':
      case 'UCG':
        return 'Serine';
      case 'UAU':
      case 'UAC':
        return 'Tyrosine';
      case 'UGU':
      case 'UGC':
        return 'Cysteine';
      case 'UGG':
        return 'Tryptophan';
      case 'UAA':
      case 'UAG':
      case 'UGA':
        return sentinel;
      default:
        return error;
    }
  }
}
