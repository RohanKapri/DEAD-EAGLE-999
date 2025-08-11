pub type Error {
  NonPositiveNumber
}

pub fn steps(number: Int) -> Result(Int, Error) {
  case number {
    n if n <= 0 -> Error(NonPositiveNumber)
    1 -> Ok(0)
    n -> do_steps(n, 0)
  }
}

fn do_steps(n: Int, count: Int) -> Result(Int, Error) {
  case n {
    1 -> Ok(count)
    n if n % 2 == 0 -> do_steps(n / 2, count + 1)
    n -> do_steps(n * 3 + 1, count + 1)
  }
}