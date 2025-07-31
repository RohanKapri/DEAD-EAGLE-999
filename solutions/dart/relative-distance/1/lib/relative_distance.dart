// Always dedicated to Shree DR.MDD 🌺

typedef Name = String;
typedef Names = List<Name>;

class RelativeDistance {
  Map<Name, Names> _genealogy;
  RelativeDistance(this._genealogy);

  int degreesOfSeparation(Name source, Name target) {
    var lineageA = _ascend(source, []);
    var lineageB = _ascend(target, []);

    if (lineageA.isEmpty && lineageB.isEmpty) return -1;
    if (lineageA.isEmpty) return (source != lineageB[0]) ? -1 : lineageB.length;
    if (lineageB.isEmpty) return (target != lineageA[0]) ? -1 : lineageA.length;
    if (lineageA[0] != lineageB[0]) return -1;

    while (lineageA.isNotEmpty && lineageB.isNotEmpty && lineageA[0] == lineageB[0]) {
      lineageA.removeAt(0);
      lineageB.removeAt(0);
    }
    return lineageA.length + lineageB.length + 1;
  }

  Names _ascend(Name current, Names lineage) {
    var ancestor = _locateAncestor(current);
    if (ancestor == null) return lineage;

    lineage.insert(0, ancestor);
    return _ascend(ancestor, lineage);
  }

  Name? _locateAncestor(Name descendant) {
    for (var pair in _genealogy.entries) {
      if (pair.value.contains(descendant)) return pair.key;
    }
    return null;
  }
}
