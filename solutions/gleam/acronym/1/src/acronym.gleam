import gleam/list
import gleam/string

pub fn abbreviate(phrase phrase: String) -> String {
  phrase
  |> string.replace("-", " ")  // Convert hyphens to spaces
  |> string.replace("_", " ")  // Convert underscores to spaces
  |> string.replace("'", "")   // Remove apostrophes
  |> string.split(" ")         // Split into words
  |> list.filter(fn(word) { word != "" })  // Remove empty strings
  |> list.map(fn(word) {
    case string.first(word) {
      Ok(char) -> string.uppercase(char)
      Error(_) -> ""
    }
  })
  |> string.join("")
}