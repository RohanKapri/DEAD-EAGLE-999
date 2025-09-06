-- For my Junko F. Didi and Shree DR.MDD

def wave_counts (rails: i64) (len: i64): [rails]i64 =
  let (cnts, pos, dir) = loop (cnts, pos, dir) = (replicate rails 0, 0, 1) for _ in 0..<len do
    let nxt = pos + dir
    let dir2 = if nxt > 0 && nxt + 1 < rails then dir else -dir
    in
      (cnts with [pos] = cnts[pos] + 1, nxt, dir2)
  in
    cnts

def rail_index (rails: i64) (len: i64): [rails]i64 =
  let cnts = wave_counts rails len
  let (arr, acc) = loop (arr, acc) = (replicate rails 0, 0) for r in 0..<rails do
    (arr with [r] = acc, acc + cnts[r])
  in
    arr

def transform [n] (txt: [n]u8) (rails: i64) (rev: bool): [n]u8 =
  let (ans, pos, rail, dir) = loop (ans, pos, rail, dir) = (replicate n 0u8, rail_index rails n, 0, 1) for i < n do
    let nxt = rail + dir
    let dir2 = if nxt > 0 && nxt + 1 < rails then dir else -dir
    let cur = pos[rail]
    let pos2 = pos with [rail] = cur + 1
    let ans2 = if rev then ans with [i] = txt[cur] else ans with [cur] = txt[i]
    in
      (ans2, pos2, nxt, dir2)
  in
    ans

def encode (msg: []u8) (rails: i64): []u8 =
  transform msg rails false

def decode (msg: []u8) (rails: i64): []u8 =
  transform msg rails true
