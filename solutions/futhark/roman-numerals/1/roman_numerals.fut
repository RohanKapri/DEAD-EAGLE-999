def describe (number: i32) (ten: u8) (five: u8) (one: u8): []u8 =
  if number == 9 then [one, ten] else
  if number == 4 then [one, five] else
  (replicate (i64.i32 (number / 5)) five) ++ (replicate (i64.i32 (number % 5)) one)

def to_roman (number: i32): []u8 =
  let thousands = number / 1000
  let hundreds = number % 1000 / 100
  let tens = number % 100 / 10
  let units = number % 10
  in
    (describe thousands '_' '_' 'M') ++ (describe hundreds 'M' 'D' 'C') ++ (describe tens 'C' 'L' 'X') ++ (describe units 'X' 'V' 'I')