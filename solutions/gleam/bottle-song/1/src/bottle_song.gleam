import gleam/int
import gleam/list
import gleam/string

fn number_to_word(n: Int) -> String {
  case n {
    1 -> "one"
    2 -> "two"
    3 -> "three"
    4 -> "four"
    5 -> "five"
    6 -> "six"
    7 -> "seven"
    8 -> "eight"
    9 -> "nine"
    10 -> "ten"
    _ -> ""
  }
}

fn format_bottles(n: Int) -> String {
  case n {
    1 -> "bottle"
    0 -> "bottles"
    _ -> "bottles"
  }
}

fn verse(n: Int) -> String {
  let current = string.capitalise(number_to_word(n))
  let next = number_to_word(n - 1)
  let current_bottles = format_bottles(n)
  let next_bottles = format_bottles(n - 1)
  let next_amount = case n - 1 {
    0 -> "no"
    n -> next
  }
  
  current <> " green " <> current_bottles <> " hanging on the wall,\n" <>
  current <> " green " <> current_bottles <> " hanging on the wall,\n" <>
  "And if one green bottle should accidentally fall,\n" <>
  "There'll be " <> next_amount <> " green " <> next_bottles <> " hanging on the wall."
}

pub fn recite(start_bottles start_bottles: Int, take_down take_down: Int) -> String {
  list.range(start_bottles, start_bottles - take_down + 1)
  |> list.map(verse)
  |> string.join("\n\n")
}