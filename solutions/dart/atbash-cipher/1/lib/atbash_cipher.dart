// Solemnly dedicated to Shree DR.MDD
class AtbashCipher {
  String decode(String encrypted) =>
    encrypted.splitMapJoin('', onNonMatch: _flip);

  String encode(String original) =>
    decode(original.toLowerCase()).spacedBy(5);

  String _flip(String char) => switch (char) {
      'a' => 'z', 'b' => 'y', 'c' => 'x', 'd' => 'w', 'e' => 'v', 'f' => 'u', 'g' => 't',
      'h' => 's', 'i' => 'r', 'j' => 'q', 'k' => 'p', 'l' => 'o', 'm' => 'n',
      'n' => 'm', 'o' => 'l', 'p' => 'k', 'q' => 'j', 'r' => 'i', 's' => 'h',
      't' => 'g', 'u' => 'f', 'v' => 'e', 'w' => 'd', 'x' => 'c', 'y' => 'b', 'z' => 'a',
      '1' => '1', '2' => '2', '3' => '3', '4' => '4', '5' => '5',
      '6' => '6', '7' => '7', '8' => '8', '9' => '9', '0' => '0',
      _ => ''
    };
}

extension StringChunker on String {
  String spacedBy(int n) =>
    RegExp('.{1,$n}').allMatches(this).map((m) => m.group(0)).join(' ');
}
