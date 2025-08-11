import gleam/list
import gleam/string

pub fn distance(strand1: String, strand2: String) -> Result(Int, Nil) {
  case string.length(strand1) == string.length(strand2) {
    False -> Error(Nil)
    True -> {
      list.zip(string.to_graphemes(strand1), string.to_graphemes(strand2))
      |> list.fold(0, fn(count, pair) {
        case pair {
          #(a, b) if a != b -> count + 1
          _ -> count
        }
      })
      |> Ok
    }
  }
}