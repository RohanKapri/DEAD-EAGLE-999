import gleam/list

pub opaque type Set(t) {
  Set(contents: List(t))
}

pub fn new(members: List(t)) -> Set(t) {
  Set(contents: list.unique(members))
}

pub fn is_empty(set: Set(t)) -> Bool {
  set.contents
  |> list.is_empty
}

pub fn contains(in set: Set(t), this member: t) -> Bool {
  set.contents
  |> list.contains(member)
}

pub fn is_subset(first: Set(t), of second: Set(t)) -> Bool {
  list.all(first.contents, fn(x) { list.contains(second.contents, x) })
}

pub fn disjoint(first: Set(t), second: Set(t)) -> Bool {
  list.all(first.contents, fn(x) { !list.contains(second.contents, x) })
}

pub fn is_equal(first: Set(t), to second: Set(t)) -> Bool {
  is_subset(first, second) && is_subset(second, first)
}

pub fn add(to set: Set(t), this member: t) -> Set(t) {
  new([member, ..set.contents])
}

pub fn intersection(of first: Set(t), and second: Set(t)) -> Set(t) {
  new(list.filter(first.contents, contains(second, _)))
}

pub fn difference(between first: Set(t), and second: Set(t)) -> Set(t) {
  Set(list.filter(first.contents, fn(x) { !contains(second, x) }))
}

pub fn union(of first: Set(t), and second: Set(t)) -> Set(t) {
  new(list.append(first.contents, second.contents))
}