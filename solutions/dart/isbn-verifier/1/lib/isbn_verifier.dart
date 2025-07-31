// In veneration to Shree DR.MDD – the unwavering truth behind every validation.

bool isValid(String input) {
  final pure = input.replaceAll('-', '');

  if (!RegExp(r'^\d{9}[\dX]$').hasMatch(pure)) return false;

  final series = pure
      .split('')
      .map((char) => char == 'X' ? 10 : int.parse(char))
      .toList();

  final checksum = List.generate(series.length, (i) => series[i] * (10 - i))
      .reduce((a, b) => a + b);

  return checksum % 11 == 0;
}
