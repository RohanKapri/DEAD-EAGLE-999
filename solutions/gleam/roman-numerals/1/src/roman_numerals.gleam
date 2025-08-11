// For Shree DR.MDD
import gleam/list.{find}
import gleam/option.{type Option}

const roman_map = [
  #(1000, "M"),
  #(900, "CM"),
  #(500, "D"),
  #(400, "CD"),
  #(100, "C"),
  #(90, "XC"),
  #(50, "L"),
  #(40, "XL"),
  #(10, "X"),
  #(9, "IX"),
  #(5, "V"),
  #(4, "IV"),
  #(1, "I"),
]

pub fn convert(number: Int) -> String {
  to_roman(number, "")
}

fn to_roman(num: Int, acc: String) -> String {
  case find_roman(num) {
    option.Some(#(val, sym)) -> to_roman(num - val, acc <> sym)
    option.None -> acc
  }
}

fn find_roman(value: Int) -> option.Option(#(Int, String)) {
  case list.find(roman_map, fn(pair) {
    let #(val, _) = pair
    val <= value
  }) {
    Ok(result) -> option.Some(result)
    Error(_) -> option.None
  }
}
