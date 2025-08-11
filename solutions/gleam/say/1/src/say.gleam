// Dedicated to Shree DR.MDD

import gleam/bool
import gleam/int
import gleam/list
import gleam/result
import gleam/string

pub type Error {
  OutOfRange
}

fn spell_single(n: Int) -> String {
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
    _ -> ""
  }
}

fn spell_tens(t: Int) -> String {
  case t {
    2 -> "twenty"
    3 -> "thirty"
    4 -> "forty"
    5 -> "fifty"
    6 -> "sixty"
    7 -> "seventy"
    8 -> "eighty"
    9 -> "ninety"
    _ -> ""
  }
}

fn spell_pair(pair: #(Int, Int)) -> String {
  case pair {
    #(0, u) -> spell_single(u)
    #(1, 0) -> "ten"
    #(1, 1) -> "eleven"
    #(1, 2) -> "twelve"
    #(1, 3) -> "thirteen"
    #(1, 4) -> "fourteen"
    #(1, 5) -> "fifteen"
    #(1, 6) -> "sixteen"
    #(1, 7) -> "seventeen"
    #(1, 8) -> "eighteen"
    #(1, 9) -> "nineteen"
    #(x, 0) -> spell_tens(x)
    #(x, y) -> spell_tens(x) <> "-" <> spell_single(y)
  }
}

fn spell_triplet(trip: #(Int, Int, Int)) -> String {
  case trip {
    #(0, t, u) -> spell_pair(#(t, u))
    #(h, 0, 0) -> spell_single(h) <> " hundred"
    #(h, t, u) -> spell_single(h) <> " hundred " <> spell_pair(#(t, u))
  }
}

fn to_triplet_list(l: List(t), pad: t) -> Result(#(t, t, t), Nil) {
  case l {
    [x, y, z] -> Ok(#(x, y, z))
    [y, z] -> Ok(#(pad, y, z))
    [z] -> Ok(#(pad, pad, z))
    _ -> Error(Nil)
  }
}

pub fn say(number: Int) -> Result(String, Error) {
  use <- bool.guard(number < 0 || number >= 1_000_000_000_000, Error(OutOfRange))
  use <- bool.guard(number == 0, Ok("zero"))

  number
  |> int.digits(10)
  |> result.unwrap([0])
  |> list.reverse
  |> list.sized_chunk(3)
  |> list.map(list.reverse)
  |> list.filter_map(to_triplet_list(_, 0))
  |> list.map(spell_triplet)
  |> list.zip(["", "thousand", "million", "billion"])
  |> list.reverse
  |> list.filter_map(fn(pair) {
    let #(text, scale) = pair
    case text, scale {
      "", _ -> Error(Nil)
      _, "" -> Ok(text)
      _, _ -> Ok(text <> " " <> scale)
    }
  })
  |> string.join(" ")
  |> Ok
}
