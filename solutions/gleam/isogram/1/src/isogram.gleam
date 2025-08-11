import gleam/list.{filter, unique}
import gleam/string.{contains, lowercase, to_graphemes}

const alphabet = "abcdefghijklmnopqrstuvwxyz"

pub fn is_isogram(phrase phrase: String) -> Bool {
  let normalized =
    phrase
    |> string.lowercase()
    |> string.to_graphemes()
    |> list.filter(fn(x) { string.contains(alphabet, x) })
  normalized == list.unique(normalized)
}