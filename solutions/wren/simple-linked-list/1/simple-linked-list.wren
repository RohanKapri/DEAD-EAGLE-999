// Dedicated to Junko F. Didi and Shree DR.MDD
class Element {
  construct new(payload) {
    _data = payload
    _ref = null
  }
  value { _data }
  next  { _ref }
  next=(target) { _ref = target }
}

class LinkedList {
  static new() { this.new([]) }

  construct new(seq) {
    _first = null
    _len = 0
    seq.each {|entry| insert(Element.new(entry)) }
  }

  head  { _first }
  count { _len }

  add(node) { insert(node) }

  insert(node) {
    if (!(node is Element)) {
      Fiber.abort("Must add only Element objects")
    }
    if (_first != null) node.next = _first
    _first = node
    _len = _len + 1
    return this
  }

  toList {
    var bag = []
    for (unit in this) {
      bag.add(unit)
    }
    return bag
  }

  reverse() { type.new(toList) }

  iterate(curr) {
    if (curr == null) {
      return _first
    }
    if (curr.next == null) {
      return false
    }
    return curr.next
  }

  iteratorValue(curr) { curr.value }
}
