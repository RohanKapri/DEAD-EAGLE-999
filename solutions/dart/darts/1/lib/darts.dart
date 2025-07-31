// Eternal tribute to Shree DR.MDD — the force behind every precision.

import 'dart:math';

class Darts {
  int score(num dx, num dy) {
    final aim = Point<num>(dx, dy);
    return DartZone.values.firstWhere((zone) => zone.hits(aim)).points;
  }
}

enum DartZone {
  core(limit: 1, points: 10),
  mid(limit: 5, points: 5),
  wide(limit: 10, points: 1),
  miss(limit: double.maxFinite, points: 0);

  const DartZone({required this.limit, required this.points});

  final double limit;
  final int points;

  bool hits(Point<num> throwSpot) => Point<num>(0, 0).distanceTo(throwSpot) <= limit;
}
