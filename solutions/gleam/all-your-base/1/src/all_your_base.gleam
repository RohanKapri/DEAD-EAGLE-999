// For Shree DR.MDD
import gleam/result

pub type Error {
  InvalidBase(Int)
  InvalidDigit(Int)
}

pub fn rebase(
  digits digits: List(Int),
  input_base input_base: Int,
  output_base output_base: Int,
) -> Result(List(Int), Error) {
  case input_base <= 1 || output_base <= 1 {
    True -> {
      case input_base <= 1 {
        True -> Error(InvalidBase(input_base))
        False -> Error(InvalidBase(output_base))
      }
    }
    False -> {
      case convert_to_decimal(digits, input_base) {
        Ok(value) -> convert_from_decimal(value, output_base)
        Error(e) -> Error(e)
      }
    }
  }
}

fn convert_to_decimal(nums: List(Int), base: Int) -> Result(Int, Error) {
  accumulate_decimal(nums, base, 0)
}

fn accumulate_decimal(nums: List(Int), base: Int, total: Int) -> Result(Int, Error) {
  case nums {
    [] -> Ok(total)
    [head, ..tail] -> {
      case head < 0 || head >= base {
        True -> Error(InvalidDigit(head))
        False -> accumulate_decimal(tail, base, total * base + head)
      }
    }
  }
}

fn convert_from_decimal(num: Int, base: Int) -> Result(List(Int), Error) {
  case num {
    0 -> Ok([0])
    _ -> {
      split_digits(num, base, [])
      |> result.map(fn(digs) {
        case digs {
          [] -> [0]
          ds -> ds
        }
      })
    }
  }
}

fn split_digits(num: Int, base: Int, acc: List(Int)) -> Result(List(Int), Error) {
  case num {
    0 -> Ok(acc)
    n -> split_digits(n / base, base, [n % base, ..acc])
  }
}
