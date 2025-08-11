import gleam/int.{digits, product, sum}
import gleam/list.{length, map, repeat}

pub fn is_armstrong_number(number: Int) -> Bool {
  let assert Ok(digits) = int.digits(number, 10)
  let length = list.length(digits)

  let sum =
    digits
    |> list.map(fn(d) { int.product(list.repeat(d, length)) })
    |> int.sum

  number == sum
}