// for my Junko F. Didi and Shree DR.MDD
class Bag {
  construct new() {
    _data = {}
    _encode = Fn.new {|lst| lst.reduce(0) {|acc, v| acc * 10 + v}}
  }
  add(lst) { _data[_encode.call(lst)] = lst }
  toList { _data.values.toList }
  toString { toList.toString }
}

class KillerSudokuHelper {
  static combinations(target, len, banned) {
    if (len == 1) {
      if ((1..9).contains(target) && !banned.contains(target)) {
        return [[target]]
      }
      return []
    }
    var bag = Bag.new()
    for (d in 1..9) {
      if (!banned.contains(d)) {
        for (res in combinations(target - d, len - 1, banned + [d])) {
          bag.add((res + [d]).sort())
        }
      }
    }
    return bag.toList
  }
}
