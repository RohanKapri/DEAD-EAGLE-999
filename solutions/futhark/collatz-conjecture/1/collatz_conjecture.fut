def steps (number: i32): i32 =
  let (count, _) = loop (count, n) = assert (number > 0) (0, number) while n > 1 do
    if n % 2 == 0 then (count + 1, n / 2) else
    (count + 2, (3 * n + 1) / 2)
  in
    count