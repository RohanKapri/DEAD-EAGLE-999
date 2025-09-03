let square_of_sum n =
  let sum = (n * (n + 1)) / 2 in
  sum * sum
let sum_of_squares n =
  let sum = n * (n + 1) * (n * 2 + 1) in
  sum / 6
let difference_of_squares n = (square_of_sum n) - (sum_of_squares n)