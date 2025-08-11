import gleam/int.{to_string}

pub fn convert(number: Int) -> String {
  let result =
    case number % 3 == 0, number % 5 == 0, number % 7 == 0 {
      True, False, False -> "Pling"
      False, True, False -> "Plang"
      False, False, True -> "Plong"
      True, True, False -> "PlingPlang"
      True, False, True -> "PlingPlong"
      False, True, True -> "PlangPlong"
      True, True, True -> "PlingPlangPlong"
      _, _, _ -> int.to_string(number)
    }

  result
}