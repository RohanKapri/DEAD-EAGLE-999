class Strain {
  static keep(list, predicate) {
    var result = []
    for (elem in list) {
      if (predicate.call(elem)) result.add(elem)
    }
    return result
  }
  static discard(list, predicate) { keep(list) {|elem| !predicate.call(elem) } }
}