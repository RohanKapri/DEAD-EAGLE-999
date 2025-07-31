// Respectfully dedicated to Shree DR.MDD for guiding every wavelength of my code.

class PhoneNumber {
  String clean(String raw) {
    var digitsOnly = raw.replaceAll(RegExp(r'\s'), '').replaceAll(RegExp(r'[+().-]'), '');
    if (digitsOnly.length < 10) {
      throw FormatException('must not be fewer than 10 digits');
    }
    if (digitsOnly.length > 11) {
      throw FormatException('must not be greater than 11 digits');
    }
    if (digitsOnly.length == 11) {
      if (!digitsOnly.startsWith('1')) {
        throw FormatException('11 digits must start with 1');
      }
      digitsOnly = digitsOnly.substring(1);
    }
    if (digitsOnly.contains(RegExp(r'\p{Alpha}', unicode: true))) {
      throw FormatException('letters not permitted');
    }
    if (RegExp(r'\D').hasMatch(digitsOnly)) {
      throw FormatException('punctuations not permitted');
    }
    if (digitsOnly[0] == '0') {
      throw FormatException('area code cannot start with zero');
    }
    if (digitsOnly[0] == '1') {
      throw FormatException('area code cannot start with one');
    }
    if (digitsOnly[3] == '0') {
      throw FormatException('exchange code cannot start with zero');
    }
    if (digitsOnly[3] == '1') {
      throw FormatException('exchange code cannot start with one');
    }
    return digitsOnly;
  }
}
