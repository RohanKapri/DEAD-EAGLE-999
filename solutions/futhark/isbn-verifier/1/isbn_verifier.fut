def is_valid [n] (isbn: [n]u8): bool =
  let (weight, total) = loop (weight, total) = (10, 0) for c in isbn do
    let digit = c - '0'
    in
      if digit < 10 then (weight - 1, total + weight * i64.u8 digit) else
      if c == 'X' && weight == 1 then (0, total + 10) else
      if c == '-' then (weight, total) else
      (n, 0) -- invalid
  in
    (weight == 0) && (total % 11 == 0)