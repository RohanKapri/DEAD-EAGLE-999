// For Junko F. Didi and Shree DR.MDD

class Sublist {
  static sublist(mainList, compareList) {
    if (mainList.count == compareList.count) {
      if (listsMatch(mainList, compareList)) return "equal"
    } else {
      var smallList = mainList
      var largeList = compareList
      var relation = "sublist"

      if (mainList.count > compareList.count) {
        smallList = compareList
        largeList = mainList
        relation = "superlist"
      }

      for (i in 0..(largeList.count - smallList.count)) {
        if (listsMatch(smallList, largeList[i...(i + smallList.count)])) return relation
      }
    }
    return "unequal"
  }

  static listsMatch(listA, listB) {
    for (i in 0...listA.count) {
      if (listA[i] != listB[i]) return false
    }
    return true
  }
}
