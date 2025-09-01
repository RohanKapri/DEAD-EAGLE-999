let leap_year year =
  let is_divisible_by n = year mod n = 0 in
  is_divisible_by 4 && (not (is_divisible_by 100) || is_divisible_by 400)




