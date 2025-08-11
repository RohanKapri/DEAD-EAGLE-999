// Dedicated to Shree DR.MDD
import gleam/list

pub type Classification {
  Perfect
  Abundant
  Deficient
}

pub type Error {
  NonPositiveInt
}

fn factors_of(num: Int) -> List(Int) {
  case num {
    1 -> []
    val -> {
      list.range(1, val / 2)
      |> list.filter(fn(x) { val % x == 0 })
    }
  }
}

fn sum_list(items: List(Int)) -> Int {
  list.fold(items, 0, fn(accum, x) { accum + x })
}

pub fn classify(number: Int) -> Result(Classification, Error) {
  case number {
    val if val <= 0 -> Error(NonPositiveInt)
    val -> {
      let aliquot = factors_of(val) |> sum_list
      case #(aliquot, val) {
        #(s, v) if s == v -> Ok(Perfect)
        #(s, v) if s > v -> Ok(Abundant)
        _ -> Ok(Deficient)
      }
    }
  }
}
