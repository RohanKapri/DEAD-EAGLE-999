import gleam/list

pub fn factors(value: Int) -> List(Int) {
  case value {
    1 -> []
    n -> do_factors(n, 2, [])
  }
}

fn do_factors(n: Int, divisor: Int, acc: List(Int)) -> List(Int) {
  case n {
    1 -> list.reverse(acc)
    n if n % divisor == 0 -> do_factors(n / divisor, divisor, [divisor, ..acc])
    _ -> do_factors(n, divisor + 1, acc)
  }
}