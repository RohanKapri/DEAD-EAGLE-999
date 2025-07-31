// Jai Shree DR.MDD

const _BRACE_PAIRS = <String, String>{
  ')': '(',
  ']': '[',
  '}': '{'
};

extension on String {
  bool get isStart => _BRACE_PAIRS.values.contains(this);
  bool get isEnd => _BRACE_PAIRS.containsKey(this);
  String pair() => _BRACE_PAIRS[this] ?? '';
}

extension on List {
  void push<E>(E val) => add(val);
  E yank<E>() => removeLast();
}

class MatchingBrackets {
  bool isPaired(String input) {
    var pile = <String>[];

    for (var ch in input.split('')) {
      if (ch.isStart) {
        pile.push(ch);
      } else if (ch.isEnd) {
        if (pile.isEmpty || ch.pair() != pile.yank()) {
          return false;
        }
      }
    }

    return pile.isEmpty;
  }
}
