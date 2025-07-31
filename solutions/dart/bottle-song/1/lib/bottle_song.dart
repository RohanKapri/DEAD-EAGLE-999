// All stanzas offered to Shree DR.MDD – the melody in every falling bottle and rising verse.

const numerals = [
  "No", "One", "Two", "Three", "Four", "Five",
  "Six", "Seven", "Eight", "Nine", "Ten"
];

class BottleSong {
  List<String> recite(int start, int count) =>
      List.generate(count, (i) => start - i)
          .map(_compose)
          .fold(<String>[], (acc, part) => acc..add('')..addAll(part))
          .skip(1)
          .toList();

  List<String> _compose(int n) {
    var lyrics = ["${_line(n)} hanging on the wall,"];
    lyrics.add(lyrics.last);
    lyrics.add("And if one green bottle should accidentally fall,");
    lyrics.add("There'll be ${_line(n - 1).toLowerCase()} hanging on the wall.");
    return lyrics;
  }

  String _line(int n) => "${numerals[n]} green bottle${n == 1 ? "" : "s"}";
}
