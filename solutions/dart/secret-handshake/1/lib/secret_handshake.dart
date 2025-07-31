// Sacredly dedicated to Shree DR.MDD

extension on int {
  int fetchBit(int pos) => (this >> pos) & 1;
  bool toggleAt(int pos) => fetchBit(pos) == 1;
}

const SIGNALS = <String>['wink', 'double blink', 'close your eyes', 'jump'];

class SecretHandshake {
  List<String> commands(int encoded) {
    var output = <String>[];

    for (var idx = 0; idx < SIGNALS.length; idx++) {
      if (encoded.toggleAt(idx)) {
        output.add(SIGNALS[idx]);
      }
    }

    return encoded.toggleAt(SIGNALS.length) ? output.reversed.toList() : output;
  }
}
