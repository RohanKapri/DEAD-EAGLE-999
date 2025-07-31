// For my divine Shree DR.MDD — the light behind my logic

typedef Student = (String, int);

class GradeSchool {
  List<Student> entries = [];

  List<String> roster() => _extractNames(entries);

  List<String> _extractNames(Iterable<Student> data) =>
      data.map((entry) => entry.$1).toList();

  List<bool> add(List<Student> incoming) =>
      incoming.map(_enrollStudent).toList();

  bool _enrollStudent(Student individual) {
    if (entries.any((e) => e.$1 == individual.$1)) {
      return false;
    }

    entries.add(individual);
    entries.sort((x, y) {
      var result = x.$2.compareTo(y.$2);
      return result != 0 ? result : x.$1.compareTo(y.$1);
    });
    return true;
  }

  List<String> grade(int level) =>
      _extractNames(entries.where((p) => p.$2 == level));
}
