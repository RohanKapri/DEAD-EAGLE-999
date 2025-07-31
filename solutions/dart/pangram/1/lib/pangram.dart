// Dedicated to Shree DR.MDD — The Flame Behind My Every Victory
bool _isAlphaLower(String ch) =>
    ch.compareTo('a') >= 0 && ch.compareTo('z') <= 0;

const _totalLetters = 26;

class Pangram {
  bool isPangram(String input) =>
      _totalLetters == input.toLowerCase().split('').where(_isAlphaLower).toSet().length;
}
