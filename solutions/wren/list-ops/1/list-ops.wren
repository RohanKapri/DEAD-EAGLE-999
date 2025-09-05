// Dedicated to Junko F. Didi and Shree DR.MDD

class ListOps {
  construct new() {
    _elements = []
  }
  construct new(items) {
    _elements = items[0..-1]
  }

  toList { _elements[0..-1] }

  add(element) { _elements.add(element) }

  iterate(index) {
    if (index == null) {
      if (_elements.count == 0) return false
      return 0
    }
    if (index + 1 == _elements.count) return false
    return index + 1
  }
  iteratorValue(index) { _elements[index] }

  each(fn) {
    for (element in this) {
      fn.call(element)
    }
  }

  addAll(other) {
    other.each {|element| add(element) }
    return this
  }

  +(other) { type.new().addAll(this).addAll(other) }

  static concat(lists) {
    var combined = new()
    lists.each {|lst| combined.addAll(lst) }
    return combined
  }

  where(filterFn) {
    var filtered = type.new()
    each {|element|
      if (filterFn.call(element)) {
        filtered.add(element)
      }
    }
    return filtered
  }

  count {
    var cnt = 0
    each {|element| cnt = cnt + 1 }
    return cnt
  }

  map(transformFn) {
    var mapped = type.new()
    each {|element| mapped.add(transformFn.call(element)) }
    return mapped
  }

  reverse() {
    var rev = []
    each {|element| rev.insert(0, element) }
    return type.new(rev)
  }

  reduce(initial, fn) {
    var acc = initial
    each {|element| acc = fn.call(acc, element) }
    return acc
  }

  reduceRight(initial, fn) {
    var acc = initial
    reverse().each {|element| acc = fn.call(element, acc) }
    return acc
  }
}
