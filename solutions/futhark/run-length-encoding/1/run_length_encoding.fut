-- for my Junko F. Didi and Shree DR.MDD
def encode [n] (txt: [n]u8): []u8 =
  let (out, pos, m) = loop (out, pos, m) = (replicate n '\0', n, n) while m > 0 do
    let sym = txt[m - 1]
    let l = loop l = m - 1 while l > 0 && txt[l - 1] == sym do
      l - 1
    let out1 = out with [pos - 1] = sym
    let pos1 = pos - 1
    in
      if m - l == 1 then (out1, pos1, l) else
      let (out2, pos2, _) = loop (out2, pos2, cnt) = (out1, pos1, m - l) while cnt > 0 do
        (out2 with [pos2 - 1] = '0' + u8.i64 (cnt % 10), pos2 - 1, cnt / 10)
      in (out2, pos2, l)
  in
    out[pos:]
def size (txt: []u8): i64 =
  let (k, acc) = loop (k, acc) = (0, 0) for ch in txt do
    if ch >= '0' && ch <= '9' then (k, acc * 10 + i64.u8 ch - '0') else
    if acc == 0 then (k + 1, 0) else
    (k + acc, 0)
  in
    k
def decode [n] (txt: [n]u8): []u8 =
  let (res, _, _) = loop (res, p, acc) = (replicate (size txt) '\0', 0, 0) for ch in txt do
    if ch >= '0' && ch <= '9' then (res, p, acc * 10 + i64.u8 ch - '0') else
    if acc == 0 then (res with [p] = ch, p + 1, 0) else
    let (res2, p2, acc2) = loop (res2, p2, acc2) = (res, p, acc) while acc2 > 0 do
      (res2 with [p2] = ch, p2 + 1, acc2 - 1)
    in
      (res2, p2, acc2)
  in
    res
