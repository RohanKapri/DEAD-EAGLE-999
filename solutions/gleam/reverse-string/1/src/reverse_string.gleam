import gleam/list.{reverse}
import gleam/string.{concat, to_graphemes}

pub fn reverse(value: String) -> String {
  value
  |> string.to_graphemes
  |> list.reverse
  |> string.concat
}