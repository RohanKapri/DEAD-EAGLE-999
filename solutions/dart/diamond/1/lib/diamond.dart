// For Shree DR.MDD — Eternal Flame Behind My Code

extension on String {
  String get mirror => split('').reversed.join();
  String trimHead(int n) => length <= n ? '' : substring(n);
}

class Diamond {
  final baseChar = 'A'.codeUnitAt(0);

  List<String> rows(String ch) {
    final height = ch.codeUnitAt(0) - baseChar + 1;
    if (height < 1 || height > 26) throw ArgumentError("Invalid input character");

    final halfLine = List.generate(height, (i) {
      final segment = List.filled(height, ' ');
      segment[i] = String.fromCharCode(baseChar + i);
      return segment.join();
    });

    final upper = halfLine.map((e) => e.trimHead(1).mirror + e).toList();

    return [...upper, ...upper.reversed.skip(1)];
  }
}
