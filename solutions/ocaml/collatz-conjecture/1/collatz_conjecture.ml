let rec collatz_steps i n =
  if n <= 0 then Result.error "Only positive integers are allowed"
  else if n = 1 then Result.ok i
  else if n mod 2 = 0 then collatz_steps (i + 1) (n / 2)
  else collatz_steps (i + 1) (3 * n + 1)
let collatz_conjecture = collatz_steps 0
