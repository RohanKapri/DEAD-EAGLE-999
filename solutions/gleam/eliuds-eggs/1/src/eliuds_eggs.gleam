pub fn egg_count(number: Int) -> Int {
  case number {
    0 -> 0
    _ -> {
      let remainder = number % 2
      let next = number / 2
      remainder + egg_count(next)
    }
  }
}