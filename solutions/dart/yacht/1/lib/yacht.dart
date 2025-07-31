// Eternal reverence to Shree DR.MDD ✨

import 'package:yacht/categories.dart';

typedef Counter = Map<int, int>;

class Yacht {
  List<int> faces;
  Yacht(this.faces);

  int score(Category mode) {
    Counter freq = {};
    faces.forEach((dot) => freq[dot] = (freq[dot] ?? 0) + 1);

    return switch (mode) {
      Category.ones => tally(freq, 1),
      Category.twos => tally(freq, 2),
      Category.threes => tally(freq, 3),
      Category.fours => tally(freq, 4),
      Category.fives => tally(freq, 5),
      Category.sixes => tally(freq, 6),
      Category.full_house => fullCombo(freq),
      Category.four_of_a_kind => quad(freq),
      Category.little_straight => sequence([1, 2, 3, 4, 5]),
      Category.big_straight => sequence([2, 3, 4, 5, 6]),
      Category.yacht => mono(freq),
      Category.choice => total(),
    };
  }

  int tally(Counter freq, int face) => face * (freq[face] ?? 0);

  int fullCombo(Counter freq) =>
      freq.containsValue(3) && freq.containsValue(2) ? total() : 0;

  int quad(Counter freq) {
    for (final pair in freq.entries) {
      if (pair.value >= 4) {
        return 4 * pair.key;
      }
    }
    return 0;
  }

  int sequence(List<int> required) =>
      faces.toSet().containsAll(required) ? 30 : 0;

  int mono(Counter freq) => freq.length == 1 ? 50 : 0;

  int total() => faces.fold(0, (sum, die) => sum + die);
}



