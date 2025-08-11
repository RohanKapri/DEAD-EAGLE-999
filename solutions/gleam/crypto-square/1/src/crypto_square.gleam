import gleam/bool.{guard}
import gleam/float
import gleam/int
import gleam/list
import gleam/result
import gleam/set
import gleam/string


pub fn ciphertext(plaintext: String) -> String {
  let alphanumerics = "abcdefghijklmnopqrstuvwxyz0123456789" 
  |> string.to_graphemes
  |> set.from_list
  
  let filtered = plaintext
  |> string.lowercase
  |> string.to_graphemes
  |> list.filter(fn(char) { alphanumerics |> set.contains(char) })

  case filtered {
    [] | [_] | [_, _, _] -> filtered |> string.join("")
    _ -> {
      let len = list.length(filtered)
      let assert Ok(rows) = int.square_root(len)
      let rows = float.round(rows)
      let cols = list.range(1, rows + 1)
      |> list.filter(fn(cols) { 
          rows*cols >= len &&
          cols >= rows &&
          cols <= rows + 1
        })
      |> list.first
      |> result.unwrap(-1)
      
      filtered
      |> list.sized_chunk(cols)
      |> list.map(fn(chunk) { end_pad_to_length(chunk, cols, " ") })
      |> list.transpose
      |> list.map(fn(chunk) { string.join(chunk, "") })
      |> string.join(" ")
    }
  }
}

fn end_pad_to_length(lst: List(a), len: Int, pad_char: a) -> List(a) {
  let list_len = list.length(lst)
  use <- guard(when: list_len >= len, return: lst)
  [lst, list.repeat(pad_char, len - list_len)] |> list.flatten
}