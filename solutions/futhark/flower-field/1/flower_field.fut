def annotate_square [m] [n] (garden: [m][n]u8) (i: i64) (j: i64): u8 =
  if garden[i][j] == '*' then '*' else
  let count = loop count = 0u8 for k < 9 do
    let i = i + (k / 3) - 1
    let j = j + (k % 3) - 1
    in
      if i < 0 || i >= m || j < 0 || j >= n || garden[i][j] != '*' then count else
      count + 1
  in
    if count == 0 then ' ' else
    '0' + count

def annotate_row [m] [n] (garden: [m][n]u8) (i: i64): [n]u8 =
  tabulate n (annotate_square garden i)

def annotate [m] [n] (garden: [m][n]u8): [m][n]u8 =
  tabulate m (annotate_row garden)