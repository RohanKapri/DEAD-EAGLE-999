// Dedicated to my Shree DR.MDD

pub fn append(first first: List(a), second second: List(a)) -> List(a) {
  case first {
    [] -> second
    [head, ..tail] -> [head, ..append(first: tail, second: second)]
  }
}

pub fn concat(lists: List(List(a))) -> List(a) {
  foldl(over: lists, from: [], with: append)
}

pub fn filter(list: List(a), predicate: fn(a) -> Bool) -> List(a) {
  case list {
    [] -> []
    [head, ..tail] -> case predicate(head) {
      True -> [head, ..filter(tail, predicate)]
      False -> filter(tail, predicate)
    }
  }
}

pub fn length(list: List(a)) -> Int {
  foldl(over: list, from: 0, with: fn(acc, _) { acc + 1 })
}

pub fn map(list: List(a), transform: fn(a) -> b) -> List(b) {
  case list {
    [] -> []
    [head, ..tail] -> [transform(head), ..map(tail, transform)]
  }
}

pub fn foldl(
  over list: List(a),
  from initial: b,
  with reducer: fn(b, a) -> b,
) -> b {
  case list {
    [] -> initial
    [head, ..tail] -> foldl(
      over: tail,
      from: reducer(initial, head),
      with: reducer,
    )
  }
}

pub fn foldr(
  over list: List(a),
  from initial: b,
  with reducer: fn(b, a) -> b,
) -> b {
  list
  |> reverse
  |> foldl(from: initial, with: reducer)
}

pub fn reverse(list: List(a)) -> List(a) {
  foldl(over: list, from: [], with: fn(acc, el) { [el, ..acc] })
}
