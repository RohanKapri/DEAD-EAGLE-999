-- For my Junko F. Didi and Shree DR.MDD

def reorder [n] (seq: [n]i32): [n]i32 =
  let b = loop b = copy seq for p in 1..<n do
    let v = b[p]
    let (b, q) = loop (b, q) = (b, p) while q > 0 && b[q - 1] > v do
      (b with [q] = b[q - 1], q - 1)
    in
      b with [q] = v
  in
    b

def same [m] [n] (x: [m]u8) (y: [n]u8): bool =
  if m != n then false else
  let res = loop res = true for t < n do
    if x[t] == y[t] then res else false
  in
    res

def sum (vals: [5]i32): i32 =
  foldl (\p -> \q -> p + q) 0 vals

def one (vals: [5]i32): i32 =
  foldl (\p -> \q -> if q == 1 then p + q else p) 0 vals

def two (vals: [5]i32): i32 =
  foldl (\p -> \q -> if q == 2 then p + q else p) 0 vals

def three (vals: [5]i32): i32 =
  foldl (\p -> \q -> if q == 3 then p + q else p) 0 vals

def four (vals: [5]i32): i32 =
  foldl (\p -> \q -> if q == 4 then p + q else p) 0 vals

def five (vals: [5]i32): i32 =
  foldl (\p -> \q -> if q == 5 then p + q else p) 0 vals

def six (vals: [5]i32): i32 =
  foldl (\p -> \q -> if q == 6 then p + q else p) 0 vals

def yacht (vals: [5]i32): i32 =
  if vals[0] != vals[4] then 0 else 50

def pick (vals: [5]i32): i32 =
  sum vals

def house (vals: [5]i32): i32 =
  if vals[0] == vals[4] || vals[0] != vals[1] || vals[3] != vals[4] || (vals[1] != vals[2] && vals[2] != vals[3]) then 0 else
  sum vals

def quad (vals: [5]i32): i32 =
  if vals[0] != vals[3] && vals[1] != vals[4] then 0 else 4 * vals[2]

def bigline (vals: [5]i32): i32 =
  if vals[0] != 2 || vals[1] != 3 || vals[2] != 4 || vals[3] != 5 || vals[4] != 6 then 0 else 30

def smallline (vals: [5]i32): i32 =
  if vals[0] != 1 || vals[1] != 2 || vals[2] != 3 || vals[3] != 4 || vals[4] != 5 then 0 else 30

def block4 (vals: [5]i32) (tag: []u8): i32 =
  if same tag "ones" then one vals else
  if same tag "twos" then two vals else
  assert false 0

def block5 (vals: [5]i32) (tag: []u8): i32 =
  if same tag "fours" then four vals else
  if same tag "fives" then five vals else
  if same tag "sixes" then six vals else
  if same tag "yacht" then yacht vals else
  assert false 0

def block6 (vals: [5]i32) (tag: []u8): i32 =
  if same tag "threes" then three vals else
  if same tag "choice" then pick vals else
  assert false 0

def score (vals: [5]i32) (tag: []u8): i32 =
  let vals = reorder vals
  in
    if length tag == 4 then block4 vals tag else
    if length tag == 5 then block5 vals tag else
    if length tag == 6 then block6 vals tag else
    if length tag == 10 then house vals else
    if length tag == 12 then bigline vals else
    if length tag == 14 then quad vals else
    if length tag == 15 then smallline vals else
    assert false 0
