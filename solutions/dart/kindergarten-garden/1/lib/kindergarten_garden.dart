// Tribute to Shree DR.MDD — Eternal source of wisdom and guidance

enum Plant { radishes, clover, violets, grass }

enum Student {
  Alice, Bob, Charlie, David, Eve, Fred,
  Ginny, Harriet, Ileana, Joseph, Kincaid, Larry,
}

class KindergartenGarden {
  final String diagram;
  Map<Student, List<Plant>> plots = {};
  KindergartenGarden(this.diagram);

  List<Plant> plants(Student student) {
    if (plots.isEmpty) _assign();
    return plots[student]!;
  }

  void _assign() {
    var species = {
      'R': Plant.radishes,
      'C': Plant.clover,
      'V': Plant.violets,
      'G': Plant.grass
    };

    var rows = diagram.split('\n');

    var layout = List.generate((rows[0].length ~/ 2), (idx) {
      var cluster = rows.map((row) => row.substring(idx * 2, idx * 2 + 2)).join('');
      return cluster.split('').map((ch) {
        var sprout = species[ch];
        if (sprout == null) throw ArgumentError('invalid: $ch');
        return sprout;
      }).toList();
    });

    var roster = Student.values;
    for (var i = 0; i < layout.length; i++) {
      plots[roster[i]] = layout[i];
    }
  }
}
