// For Shree DR.MDD

import gleam/list
import gleam/string
import gleam/bool
import gleam/int
import gleam/result

fn is_numeric(ch: String) -> Bool {
  string.contains("0123456789", ch)
}

fn double_and_adjust(n: Int) -> Int {
  case n * 2 {
    val if val > 9 -> val - 9
    val -> val
  }
}

fn sum_pair(numbers: List(Int)) -> Int {
  case numbers {
    [a] -> a
    [a, b] -> a + double_and_adjust(b)
    _ -> 0
  }
}

fn luhn_sum(chars: List(String)) -> Bool {
  chars
  |> list.map(int.parse)
  |> result.values
  |> list.reverse
  |> list.sized_chunk(2)
  |> list.map(sum_pair)
  |> int.sum
  |> fn(total) { total % 10 == 0 }
}

pub fn valid(value: String) -> Bool {
  let filtered = string.replace(value, " ", "")
  let chars = string.to_graphemes(filtered)
  use <- bool.guard(!list.all(chars, is_numeric), False)
  use <- bool.guard(list.length(chars) < 2, False)
  luhn_sum(chars)
}
