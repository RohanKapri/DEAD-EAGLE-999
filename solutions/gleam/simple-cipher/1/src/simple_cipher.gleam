import gleam/int
import gleam/list
import gleam/result
import gleam/string

pub fn encode(plaintext plaintext: String, key key: String) -> String {
  let key = prepare_key(key, string.length(plaintext))
  apply_key(plaintext, key)
}

pub fn decode(ciphertext ciphertext: String, key key: String) -> String {
  prepare_key(key, string.length(ciphertext))
  |> list.map(fn(k) { { -k + 26 } % 26 })
  |> apply_key(ciphertext, _)
}

fn apply_key(plaintext: String, key: List(Int)) -> String {
  plaintext
  |> string_to_codepoints
  |> list.zip(key)
  |> list.map(fn(p) { { p.0 - 97 + p.1 } % 26 + 97 })
  |> string_from_codepoints
}

pub fn generate_key() -> String {
  list.range(0, 100)
  |> list.map(fn(_) { int.random(122 - 97) + 97 })
  |> string_from_codepoints
}

fn prepare_key(key: String, length: Int) -> List(Int) {
  string.repeat(key, { length / string.length(key) + 1 })
  |> string_to_codepoints
  |> list.map(fn(c) { c - 97 })
}

// string to ascii lib

fn string_to_codepoints(phrase: String) -> List(Int) {
  phrase
  |> string.to_utf_codepoints
  |> list.map(string.utf_codepoint_to_int)
}

fn string_from_codepoints(codepoints: List(Int)) -> String {
  codepoints
  |> list.map(string.utf_codepoint)
  |> result.all
  |> result.unwrap([])
  |> string.from_utf_codepoints
}