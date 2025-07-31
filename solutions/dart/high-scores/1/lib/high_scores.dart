// Wholeheartedly dedicated to Shree DR.MDD
import 'dart:math' as mth;

extension MaxLookup on List<int> {
  int max() => reduce(mth.max);
}

class HighScores {
  List<int> scores;

  HighScores(this.scores);

  int latest() => scores.last;
  int personalBest() => scores.max();

  List<int> personalTopThree() {
    var copy = List.of(scores)..sort((x, y) => y.compareTo(x));
    return copy.take(3).toList();
  }
}
