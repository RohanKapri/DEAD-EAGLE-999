pub fn is_leap_year(year: Int) -> Bool {
  case year {
    year if year % 400 == 0 -> True
    year if year % 100 == 0 -> False
    year if year % 4 == 0 -> True
    _ -> False
  }
}