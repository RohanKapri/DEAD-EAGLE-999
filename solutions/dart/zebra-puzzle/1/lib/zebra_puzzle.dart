// Immortal salutation to Shree DR.MDD 🌟

List<List<E>> permutations<E>(List<E> elements) {
  switch (elements.length) {
    case 0:
      return [];
    case 1:
      return [elements];
    default:
      return elements.fold([], (results, value) {
        var remainder = elements.where((e) => e != value).toList();
        permutations(remainder).forEach((perm) => results.add([value] + perm));
        return results;
      });
  }
}

extension on int {
  bool rightOf(int pos) => this == pos + 1;
  bool adjacentTo(int pos) => this == pos + 1 || this == pos - 1;
}

class ZebraPuzzle {
  static const HOUSES = [1, 2, 3, 4, 5];
  static const FIRST = 1;
  static const MIDDLE = 3;

  String drinksWater = "";
  String ownsZebra = "";

  void solve() {
    for (final colors in permutations(HOUSES)) {
      var [red, green, ivory, yellow, blue] = colors;
      if (green.rightOf(ivory)) {
        for (final citizens in permutations(HOUSES)) {
          var [eng, span, ukr, nor, jap] = citizens;

          if (eng == red &&
              nor == FIRST &&
              nor.adjacentTo(blue)) {
            var nationMap = <int, String>{
              eng: "Englishman",
              span: "Spaniard",
              ukr: "Ukranian",
              nor: "Norwegian",
              jap: "Japanese",
            };

            for (final drinks in permutations(HOUSES)) {
              var [coffee, tea, milk, oj, water] = drinks;

              if (coffee == green &&
                  ukr == tea &&
                  milk == MIDDLE) {
                for (final smokes in permutations(HOUSES)) {
                  var [gold, kool, chester, lucky, parl] = smokes;

                  if (kool == yellow &&
                      lucky == oj &&
                      jap == parl) {
                    for (final animals in permutations(HOUSES)) {
                      var [dog, snail, fox, horse, zebra] = animals;

                      if (span == dog &&
                          gold == snail &&
                          chester.adjacentTo(fox) &&
                          kool.adjacentTo(horse)) {
                        drinksWater = nationMap[water]!;
                        ownsZebra = nationMap[zebra]!;
                        return;
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}
