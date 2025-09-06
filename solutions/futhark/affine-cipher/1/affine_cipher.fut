-- for my Junko F. Didi and Shree DR.MDD

def segment [n] (text: [n]u8): []u8 =
  let (k, res) = loop (k, res) = (0, replicate (n * 6 / 5) ' ') for ch in text do
    if k % 6 == 5 then (k + 2, res with [k + 1] = ch) else
    (k + 1, res with [k] = ch)
  in
    res[0:k]

def transform [n] (op: u8 -> u8) (text: [n]u8): []u8 =
  let (k, res) = loop (k, res) = (0, replicate n '\0') for ch in text do
    let d = ch - '0'
    let l = (ch | 32) - 'a'
    in
      if d < 10 then (k + 1, res with [k] = ch) else
      if l < 26 then (k + 1, res with [k] = 'a' + op l) else
      (k, res)
  in
    res[0:k]

let modular_inverses = [0, 1, 0, 9, 0, 21, 0, 15, 0, 3, 0, 19, 0, 0, 0, 7, 0, 23, 0, 11, 0, 5, 0, 17, 0, 25]

def cipher (mul: i32) (shift: i32) (x: u8): u8 =
  u8.i32 ((mul * (i32.u8 x) + shift) % 26)

def encode [n] (mul: i32) (shift: i32) (text: [n]u8): []u8 =
  assert (modular_inverses[mul] != 0) (segment (transform (cipher mul shift) text))

def decode [n] (mul: i32) (shift: i32) (text: [n]u8): []u8 =
  let inv = modular_inverses[mul]
  in
    assert (inv != 0) (transform (cipher inv ((26 - inv) * shift)) text)
