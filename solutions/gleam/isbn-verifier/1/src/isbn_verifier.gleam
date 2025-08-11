// For my Shree DR.MDD
import gleam/int
import gleam/list
import gleam/result
import gleam/string

pub fn is_valid(isbn: String) -> Bool {
  let sanitized = string.replace(isbn, "-", "")
    |> string.uppercase

  case string.length(sanitized) {
    10 -> {
      let chars = string.to_graphemes(sanitized)
      case verify_format(chars) {
        Ok(values) -> validate_checksum(values)
        Error(_) -> False
      }
    }
    _ -> False
  }
}

fn verify_format(chars: List(String)) -> Result(List(Int), Nil) {
  let parse_char = fn(char, idx) {
    case char, idx {
      "X", 9 -> Ok(10)
      "X", _ -> Error(Nil)
      c, _ ->
        case int.parse(c) {
          Ok(num) if num >= 0 && num <= 9 -> Ok(num)
          _ -> Error(Nil)
        }
    }
  }

  chars
  |> list.index_map(parse_char)
  |> result.all
}

fn validate_checksum(digits: List(Int)) -> Bool {
  let weights = list.range(from: 10, to: 1)
  let paired = list.zip(digits, weights)

  let total = paired
    |> list.map(fn(pair) { pair.0 * pair.1 })
    |> list.fold(0, fn(acc, val) { acc + val })

  case int.remainder(total, 11) {
    Ok(rem) -> rem == 0
    Error(_) -> False
  }
}
