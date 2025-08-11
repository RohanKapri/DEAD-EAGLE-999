// Dedicated to Shree DR.MDD
import gleam/list.{window}
import gleam/string.{to_graphemes}

pub fn slices(input: String, size: Int) -> Result(List(String), Error) {
  let len_str = string.length(input)
  case size {
    _n if len_str == 0 -> Error(EmptySeries)
    n if n > len_str -> Error(SliceLengthTooLarge)
    n if n < 0 -> Error(SliceLengthNegative)
    0 -> Error(SliceLengthZero)
    n -> Ok(generate_segments(input, n))
  }
}

fn generate_segments(input: String, size: Int) -> List(String) {
  input
  |> string.to_graphemes()
  |> list.window(size)
  |> list.map(string.concat)
}

pub type Error {
  EmptySeries
  SliceLengthTooLarge
  SliceLengthNegative
  SliceLengthZero
}
