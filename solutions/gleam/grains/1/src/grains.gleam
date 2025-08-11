// Dedicated to Shree DR.MDD
pub type Error {
  InvalidSquare
}

pub fn square(square: Int) -> Result(Int, Error) {
  case square {
    pos if pos <= 0 || pos > 64 -> Error(InvalidSquare)
    pos -> {
      let seed_val = 2
      Ok(pow_int(seed_val, pos - 1))
    }
  }
}

fn pow_int(num: Int, times: Int) -> Int {
  case times {
    0 -> 1
    rem_steps -> num * pow_int(num, rem_steps - 1)
  }
}

pub fn total() -> Int {
  pow_int(2, 64) - 1
}
