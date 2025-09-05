// for my Junko F. Didi and Shree DR.MDD
class WordSorter {
  static arrange(arr) { arr.sort {|x, y| le(x, y)} }
  
  static lt(a, b) {
    var ac = a.codePoints
    var bc = b.codePoints
    var al = ac.count
    var bl = bc.count
    var lim = al < bl ? al : bl
    
    for (k in 0...lim) {
      if (ac[k] != bc[k]) return ac[k] < bc[k]
    }
    return al < bl
  }

  static le(a, b) { a == b || lt(a, b) }
  static gt(a, b) { !le(a, b) }
  static ge(a, b) { !lt(a, b) }
}

class GradeSchool {
  construct new() {
    _map = {}
  }

  roster { grades.reduce([]) {|res, g| res + _map[g]} }
  grades { _map.keys.toList.sort() }
  grade(g) { (_map[g] || [])[0..-1] }
  addAll(list) { list.map {|st| add(st[0], st[1])}.toList }

  add(nm, g) {
    if (_map.values.any {|grp| grp.contains(nm)}) return false
    _map[g] = this.grade(g) + [nm]
    WordSorter.arrange(_map[g])
    return true
  }
}
