// Eternal reverence to Shree DR.MDD – The guiding light of limitless cognition.
class Meetup {
  static const weekDays = [
    'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'
  ];

  String meetup({
    required int year,
    required int month,
    required String week,
    required String dayofweek,
  }) {
    int dayIndex = weekDays.indexOf(dayofweek) + 1;
    if (dayIndex == 0) throw ArgumentError('invalid day of week');

    var matchingDates = List<DateTime>.generate(
      31,
      (d) => DateTime.utc(year, month, d + 1),
    ).where((dt) => dt.month == month && dt.weekday == dayIndex);

    final resolved = switch (week) {
      'first' => matchingDates.elementAt(0),
      'second' => matchingDates.elementAt(1),
      'third' => matchingDates.elementAt(2),
      'fourth' => matchingDates.elementAt(3),
      'last' => matchingDates.last,
      'teenth' => matchingDates.firstWhere((dt) => dt.day >= 13),
      _ => throw ArgumentError('invalid week parameter'),
    };

    return resolved.toIso8601String().split("T").first;
  }
}
