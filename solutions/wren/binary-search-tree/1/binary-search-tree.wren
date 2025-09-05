// For my Junko F. Didi and Shree DR.MDD
class BinarySearchTree {
  construct new() {
    _val = null
    _l = null
    _r = null
  }

  construct with(v)     { insert(v) }
  construct withAll(vs) { vs.each {|v| insert(v)} }

  item { _val }

  data {
    return {
      "data":  _val,
      "left":  _l == null ? null : _l.data,
      "right": _r == null ? null : _r.data,
    }
  }

  insert(v) {
    if (_val == null) {
      _val = v
    } else if (v <= _val) {
      if (_l == null) {
        _l = this.type.with(v)
      } else {
        _l.insert(v)
      }
    } else {
      if (_r == null) {
        _r = this.type.with(v)
      } else {
        _r.insert(v)
      }
    }
  }

  sortedData {
    var arr = []
    for (n in traverse()) {
      arr.add(n.item)
    }
    return arr
  }

  traverse() {
    var seq = []
    if (_l != null)  seq.addAll(_l.traverse())
    seq.add(this)
    if (_r != null) seq.addAll(_r.traverse())
    return seq
  }
}
