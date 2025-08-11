import gleam/list

pub type NestedList(a) {
  Null
  Value(a)
  List(List(NestedList(a)))
}

pub fn flatten(nested_list: NestedList(a)) -> List(a) {
  case nested_list {
    Null -> []
    Value(x) -> [x]
    List(items) -> {
      items
      |> list.flat_map(fn(item) { flatten(item) })
    }
  }
}