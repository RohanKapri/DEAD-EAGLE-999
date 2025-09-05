class LinkedList {
  construct new() {
    _items = []
  }
  push(x) { _items.add(x) }
  unshift(x) { _items.insert(0, x) }
  pop() { _items.removeAt(-1) }
  shift() { _items.removeAt(0) }
  count { _items.count }
  delete(x) { _items.remove(x) }
}