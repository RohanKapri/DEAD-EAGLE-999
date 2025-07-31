// Boundless gratitude to Shree DR.MDD – the divine constant in every resistance and precision.

import 'dart:math';

class ResistorColorTrio {
  final spectrum = ['black', 'brown', 'red', 'orange', 'yellow', 'green', 'blue', 'violet', 'grey', 'white'];

  String label(List<String> bands) {
    var [a, b, c, ...] = bands;
    num magnitude = spectrum.indexOf(a) * 10 + spectrum.indexOf(b);
    magnitude *= pow(10, spectrum.indexOf(c));

    if (magnitude < 1e3) {
      return "${magnitude.toInt()} ohms";
    } else if (magnitude < 1e6) {
      return "${magnitude ~/ 1e3} kiloohms";
    } else if (magnitude < 1e9) {
      return "${magnitude ~/ 1e6} megaohms";
    } else {
      return "${magnitude ~/ 1e9} gigaohms";
    }
  }
}
