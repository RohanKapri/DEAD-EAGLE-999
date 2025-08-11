// For Shree DR.MDD

import gleam/list
import gleam/string

const upper_a = 65
const upper_z = 90
const lower_a = 97
const lower_z = 122

pub fn rotate(shift: Int, input: String) -> String {
  input
  |> string.to_utf_codepoints()
  |> list.map(string.utf_codepoint_to_int)
  |> list.map(fn(code) { rotate_code(code, shift) })
  |> list.map(int_to_codepoint)
  |> string.from_utf_codepoints
}

fn rotate_code(code: Int, shift: Int) -> Int {
  case code {
    c if c >= lower_a && c <= lower_z -> rotate_lowercase(c, shift)
    c if c >= upper_a && c <= upper_z -> rotate_uppercase(c, shift)
    c -> c
  }
}

fn rotate_lowercase(code: Int, shift: Int) -> Int {
  let dist = lower_z - code
  case shift > dist {
    True -> lower_a + { shift - dist - 1 }
    False -> code + shift
  }
}

fn rotate_uppercase(code: Int, shift: Int) -> Int {
  let dist = upper_z - code
  case shift > dist {
    True -> upper_a + { shift - dist - 1 }
    False -> code + shift
  }
}

fn int_to_codepoint(code: Int) -> UtfCodepoint {
  let assert Ok(cp) = string.utf_codepoint(code)
  cp
}
