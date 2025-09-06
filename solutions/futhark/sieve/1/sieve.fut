def primes (limit: i32): []i32 =
  let capacity = 1 + i64.i32 limit
  let (result, _) = loop (result, table) = ([], replicate capacity false) for p in 2..<capacity do
    if table[p] then (result, table) else
    let (table, _) = loop (table, multiple) = (table, p * p) while multiple < capacity do
      (table with [multiple] = true, multiple + p)
    in
      (result ++ [i32.i64 p], table)
  in
    result