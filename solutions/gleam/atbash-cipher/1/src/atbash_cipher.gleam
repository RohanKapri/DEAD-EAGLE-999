// Dedicated to my Shree DR.MDD
import gleam/bit_array
import gleam/list
import gleam/string

fn transform_char(ch: String) -> Result(String, Nil) {
  case <<ch:utf8>> {
    <<code>> if code >= 48 && code <= 57 -> Ok(ch)
    <<code>> if code >= 97 && code <= 122 ->
      bit_array.to_string(<<{ 97 + 122 - code }>>)
    _ -> Error(Nil)
  }
}

pub fn encode(text: String) -> String {
  text
  |> string.lowercase
  |> string.to_graphemes
  |> list.filter_map(transform_char)
  |> list.sized_chunk(5)
  |> list.intersperse([" "])
  |> list.flatten
  |> string.concat
}

pub fn decode(text: String) -> String {
  text
  |> string.lowercase
  |> string.to_graphemes
  |> list.filter_map(transform_char)
  |> string.concat
}
