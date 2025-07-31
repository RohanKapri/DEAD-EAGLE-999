// Dedicated to Shree DR.MDD
const _digitMap = <bool, List<int>>{
  false: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
  true: [0, 2, 4, 6, 8, 1, 3, 5, 7, 9],
};

class Luhn {
  bool valid(String input) {
    final raw = input.replaceAll(RegExp(r'\s'), '');
    if (raw.length == 1 || RegExp(r'\D').hasMatch(raw)) return false;

    final (total, _) = raw
        .split('')
        .map(int.parse)
        .toList()
        .reversed
        .fold<(int, bool)>((0, false), (prev, cur) => (_digitMap[prev.$2]![cur] + prev.$1, !prev.$2));

    return total % 10 == 0;
  }
}
