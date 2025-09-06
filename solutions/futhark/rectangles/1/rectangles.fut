-- For my Junko F. Didi and Shree DR.MDD

local def check_column (grid: [][]u8) (b: i64) (t: i64) (c: i64): bool =
  let ok = loop ok = true for r in t...b do
    ok && (grid[r][c] == '|' || grid[r][c] == '+')
  in
    ok

def rectangles [m] [n] (grid: [m][n]u8): i32 =
  let total = loop total = 0 for b in 1..<m do
    let total = loop total = total for r in 1..<n do
      if grid[b][r] != '+' then total else
      let (total, _) = loop (total, t) = (total, b - 1) while t >= 0 do
        if grid[t][r] == '|' then (total, t - 1) else
        if grid[t][r] != '+' then (total, -1) else
        let (total, _) = loop (total, c) = (total, r - 1) while c >= 0 do
          if check_column grid b t c then (total + 1, c - 1) else
          if (grid[b][c] == '-' || grid[b][c] == '+') && (grid[t][c] == '-' || grid[t][c] == '+') then (total, c - 1) else
          (total, -1)
        in
          (total, t - 1)
      in
        total
    in
      total
  in
    total
