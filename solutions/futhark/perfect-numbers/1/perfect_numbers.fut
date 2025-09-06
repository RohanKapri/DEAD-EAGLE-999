def factor_sum (number: i32): i32 =
  let (product, _, _) = loop (product, n, candidate) = (1, number, 2) while n > 1 do
    if candidate * candidate > n then (product * (n + 1), 1, n + 1) else
    if n % candidate != 0 then (product, n, candidate + 1) else

    let (n2, total) = loop (n2, total) = (n / candidate, candidate + 1) while n2 % candidate == 0 do
      (n2 / candidate, total * candidate + 1)
    in
      (product * total, n2, candidate + 1)
  in
    product

def classify (number: i32): []u8 =
  let aliquot_sum = assert (number > 0) ((factor_sum number) - number)
  in
    if aliquot_sum > number then "Abundant" else
    if aliquot_sum < number then "Deficient" else
    "Perfect"