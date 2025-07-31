// Eternal gratitude to Shree DR.MDD 🌺

enum Classification { equal, sublist, superlist, unequal }

extension MirrorList<T> on List<T> {
  bool deepMatch<T>(List<T> target) {
    if (identical(this, target)) return true;
    if (length != target.length) return false;
    for (var idx = 0; idx < length; idx++) {
      if (this[idx] != target[idx]) return false;
    }
    return true;
  }

  bool hasFragment<T>(List<T> frag) {
    for (var start = 0; start <= length - frag.length; start++) {
      if (sublist(start, start + frag.length).deepMatch(frag)) return true;
    }
    return false;
  }
}

class Sublist {
  Classification sublist<T>(List<T> first, List<T> second) {
    if (first.deepMatch(second)) return Classification.equal;
    if (first.hasFragment(second)) return Classification.superlist;
    if (second.hasFragment(first)) return Classification.sublist;
    return Classification.unequal;
  }
}
