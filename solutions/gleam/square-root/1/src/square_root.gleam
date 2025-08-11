pub fn square_root(radicand: Int) -> Int {
  case radicand {
    1 -> 1
    n -> newton_method(n, n / 2)
  }
}

fn newton_method(n: Int, guess: Int) -> Int {
  let next = {guess + n / guess} / 2
  case next >= guess {
    True -> guess
    False -> newton_method(n, next)
  }
}