import gleam/list.{append, map, prepend, reverse, zip}
import gleam/result.{unwrap}

pub fn rows(n: Int) -> List(List(Int)) {
  case n {
    0 -> []
    1 -> [[1]]
    _ -> {
      let prev_rows = rows(n - 1)
      let prev_row = list.last(prev_rows)
        |> result.unwrap([])

      let new_row = zip(prepend(prev_row, 0), append(prev_row, [0]))
        |> map(fn(pair) { pair.0 + pair.1 })
        |> reverse()

      append(prev_rows, [new_row])
    }
  }
}