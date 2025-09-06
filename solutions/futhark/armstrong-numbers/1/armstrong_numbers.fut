def power (base: i32) (exponent: i32) =
  let product = loop product = 1 for _ in 0..<exponent do
    product * base
  in
    product

def decimal_digits (number: i32): []i32 =
  let (_, suffix) = loop (n, suffix) = (number, []) while n > 0 do
    (n / 10, [n % 10] ++ suffix)
  in
    suffix

def is_armstrong_number (number: i32): bool =
  let digits = decimal_digits number
  let count = i32.i64 (length digits)
  let sum = loop sum = 0 for digit in digits do
    sum + power digit count
  in
    sum == number