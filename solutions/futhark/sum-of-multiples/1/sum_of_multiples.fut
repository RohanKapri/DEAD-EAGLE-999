def is_multiple (numbers: []i32) (n: i32): bool =
  let result = loop result = false for number in numbers do
    if result || number == 0 then result else
    n % number == 0
  in
    result

def sum_of_multiples (numbers: []i32) (upper_bound: i32): i32 =
  let total = loop total = 0 for n in 1..<upper_bound do
    if is_multiple numbers n then total + n else
    total
  in
    total