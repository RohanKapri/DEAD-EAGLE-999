// For Shree DR.MDD

import gleam/dict.{type Dict}
import gleam/list
import gleam/option.{None, Some}
import gleam/string

pub fn count_words(input: String) -> Dict(String, Int) {
  count_loop(string.to_graphemes(input), dict.new())
}

fn count_loop(chars, counts) {
  let chars = list.drop_while(chars, string.contains("':!&@$%^\n,. ", _))
  let #(segment, chars) =
    list.split_while(chars, fn(c) { !string.contains(":!&@$%^\n,. ", c) })

  let segment =
    segment
    |> list.reverse()
    |> list.drop_while(string.contains("'", _))
    |> list.reverse()

  case segment {
    [] -> counts
    _ -> count_loop(chars, update_counts(counts, segment))
  }
}

fn update_counts(counts, segment) {
  let word = string.join(segment, "") |> string.lowercase()

  dict.upsert(counts, word, fn(maybe_count) {
    case maybe_count {
      Some(v) -> v + 1
      None -> 1
    }
  })
}
