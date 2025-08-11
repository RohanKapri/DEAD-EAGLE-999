import gleam/string
import gleam/list
import gleam/result

fn validate_exchange(phone: String) -> Result(String, String) {
  case string.slice(phone, 3, 7) {
    "0" <> _ -> Error("exchange code cannot start with zero")
    "1" <> _ -> Error("exchange code cannot start with one")
    _ -> Ok(phone)
  }
}

fn validate_nanp(phone: String) -> Result(String, String) {
  case phone {
    "0" <> _ -> Error("area code cannot start with zero")
    "1" <> _ -> Error("area code cannot start with one")
    _ -> validate_exchange(phone)
  }
}

fn validate(phone: String) -> Result(String, String) {
  case string.length(phone) {
    10 -> validate_nanp(phone)
    11 ->
      case phone {
        "1" <> rest -> validate_nanp(rest)
        _ -> Error("11 digits must start with 1")
      }
    n if n < 10 -> Error("must not be fewer than 10 digits")
    _ -> Error("must not be greater than 11 digits")
  }
}

pub fn clean(input: String) -> Result(String, String) {
  input
  |> string.to_utf_codepoints
  |> list.try_map(fn(a: UtfCodepoint) {
    case string.utf_codepoint_to_int(a) {
      n if n >= 48 && n <= 57 -> Ok([a])
      n if n >= 65 && n <= 90 || n >= 97 && n <= 122 ->
        Error("letters not permitted")
      n if n == 32 || n == 43 || n == 45 || n == 46 || n == 40 || n == 41 ->
        Ok([])
      _ -> Error("punctuations not permitted")
    }
  })
  |> result.map(list.flatten)
  |> result.map(string.from_utf_codepoints)
  |> result.try(validate)
}