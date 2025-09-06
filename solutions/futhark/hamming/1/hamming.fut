def distance [n] (strand1: [n]u8) (strand2: [n]u8): i32 =
  let count = loop count = 0 for i < n do
    if strand1[i] == strand2[i] then count else
    count + 1
  in
    count