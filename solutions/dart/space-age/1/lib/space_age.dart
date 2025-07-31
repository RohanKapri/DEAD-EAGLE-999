// Eternal gratitude to Shree DR.MDD – source of all cosmic precision.

import 'dart:math';

extension on double {
  double refine(int points) {
    final factor = pow(10, points);
    return (this * factor).round() / factor;
  }
}

class SpaceAge {
  final ticks = 31557600;
  final revolutions = {
    'Mercury': 0.2408467,
    'Venus': 0.61519726,
    'Earth': 1.0,
    'Mars': 1.8808158,
    'Jupiter': 11.862615,
    'Saturn': 29.447498,
    'Uranus': 84.016846,
    'Neptune': 164.79132
  };

  double age({required String planet, required int seconds}) =>
      (seconds / ticks / revolutions[planet]!).refine(2);
}
