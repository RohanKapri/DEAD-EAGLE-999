pub fn keep(list: List(t), predicate: fn(t) -> Bool) -> List(t) {
  case list {
    [] -> []
    [x, ..xs] -> {
      let tail = keep(xs, predicate)
      case predicate(x) {
        True -> [x, ..tail]
        False -> tail
      }
    }
  }
}

pub fn discard(list: List(t), predicate: fn(t) -> Bool) -> List(t) {
  case list {
    [] -> []
    [x, ..xs] -> {
      let tail = discard(xs, predicate)
      case predicate(x) {
        True -> tail
        False -> [x, ..tail]
      }
    }
  }
}