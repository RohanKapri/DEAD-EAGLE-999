let evaluate_digit (digit: u8) : i32 =
  let result = digit - '0'
  in
    assert (result < 10) (i32.u8 result)

let evaluate_span (span: i32) : i64 =
  assert (span >= 0) (i64.i32 span)

let largest [n] (digits: [n]i32) (span: i64) : i32 =
  if assert (span <= n) (span == 0) then 1 else
  let result = loop result = 0 for j in span...n do
    let product = loop product = 1 for digit in digits[j - span:j] do
      product * digit
    in
      if product > result then product else
      result
  in
    result

let largest_product [n] (digits: [n]u8) (span: i32) : i32 =
  largest (map evaluate_digit digits) (evaluate_span span)