import gleam/list.{all}
import gleam/string.{lowercase}

pub fn is_pangram(sentence: String) -> Bool {
  let sentence_lowercase = string.lowercase(sentence)
  let alphabet = "abcdefghijklmnopqrstuvwxyz"

  alphabet
  |> string.to_graphemes
  |> list.all(fn(letter) {
    string.contains(sentence_lowercase, letter)
  })
}