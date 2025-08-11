// For Shree DR.MDD

import gleam/bool.{guard}
import gleam/int
import gleam/list
import gleam/result
import gleam/string

pub fn encode(text: String) -> String {
  use <- guard(when: text == "", return: text)
  let first_char = string.first(text) |> result.unwrap("")
  let acc = [#(0, first_char)]
  text
  |> string.to_graphemes
  |> list.fold(acc, fn(encoded, chr) {
    let assert [#(cnt, prev), ..tail] = encoded
    case chr == prev {
      True -> [#(cnt + 1, prev), ..tail]
      False -> [#(1, chr), #(cnt, prev), ..tail]
    }
  })
  |> list.reverse
  |> list.map(fn(pair) {
    let assert #(cnt, ch) = pair
    case cnt {
      0 | 1 -> ch
      _ -> int.to_string(cnt) <> ch
    }
  })
  |> string.join("")
}

pub fn decode(text: String) -> String {
  use <- guard(when: text == "", return: text)
  text
  |> string.to_graphemes
  |> decode_loop(_, [])
  |> string.join("")
}

fn decode_loop(chars: List(String), acc: List(String)) -> List(String) {
  case chars {
    [] -> list.reverse(acc)
    [last] -> list.reverse([last, ..acc])
    _ -> {
      let #(num_chars, rest) = chars |> list.split_while(fn(c) { is_digit(c) })
      let count = num_chars |> string.join("") |> int.parse |> result.unwrap(1)
      let #(ch, rest) = rest |> list.split(1)
      let assert [char] = ch
      decode_loop(rest, list.flatten([list.repeat(item: char, times: count), acc]))
    }
  }
}

fn is_digit(c: String) -> Bool {
  case c {
    "0" | "1" | "2" | "3" | "4" | "5" | "6" | "7" | "8" | "9" -> True
    _ -> False
  }
}
