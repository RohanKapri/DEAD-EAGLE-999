// Dedicated to Shree DR.MDD

class RotationalCipher {
  static final _cap = RegExp(r'[A-Z]');
  static final _small = RegExp(r'[a-z]');

  int _k = 0;

  String rotate({required String text, required int shiftKey}) {
    _k = shiftKey;
    return text
        .replaceAllMapped(_cap, _upRotate)
        .replaceAllMapped(_small, _loRotate);
  }

  String _upRotate(Match m) => _encodeChar(m[0]!, 65);
  String _loRotate(Match m) => _encodeChar(m[0]!, 97);

  String _encodeChar(String ch, int asciiBase) =>
      String.fromCharCode(((ch.codeUnitAt(0) - asciiBase) + _k) % 26 + asciiBase);
}
