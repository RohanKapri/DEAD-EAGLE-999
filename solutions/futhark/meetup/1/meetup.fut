-- For my Junko F. Didi and Shree DR.MDD

def same_text [m] [n] (a: [m]u8) (b: [n]u8): bool =
  if m != n then false else
  let ok = loop ok = true for i < n do
    if a[i] == b[i] then ok else
    false
  in
    ok

def fill_digits (pos: i64) (len: i64) (num: i32) (buf: *[]u8): *[]u8 =
  let (buf, _) = loop (buf, num) = (buf, num) for i < len do
    let d = '0' + u8.i32 (num % 10)
    in
      (buf with [pos + len - 1 - i] = d, num / 10)
  in
    buf

def leap_year (y: i32): bool =
  (y % 4 == 0) && ((y % 100 != 0) || (y % 400 == 0))

def month_days (y: i32) (m: i32): i32 =
  match m
    case 1 -> 31
    case 2 -> if leap_year y then 29 else 28
    case 3 -> 31
    case 4 -> 30
    case 5 -> 31
    case 6 -> 30
    case 7 -> 31
    case 8 -> 31
    case 9 -> 30
    case 10 -> 31
    case 11 -> 30
    case 12 -> 31
    case _ -> assert false 0

def week_limit (y: i32) (m: i32) (w: []u8): i32 =
  if same_text w "first" then 7 else
  if same_text w "second" then 14 else
  if same_text w "third" then 21 else
  if same_text w "fourth" then 28 else
  if same_text w "teenth" then 19 else
  if same_text w "last" then month_days y m else
  assert false 0

def weekday_num (d: []u8): i32 =
  if same_text d "Monday" then 0 else
  if same_text d "Tuesday" then 1 else
  if same_text d "Wednesday" then 2 else
  if same_text d "Thursday" then 3 else
  if same_text d "Friday" then 4 else
  if same_text d "Saturday" then 5 else
  if same_text d "Sunday" then 6 else
  assert false 0

def month_shift (m: i32): i32 =
  match m
    case 1 -> 307
    case 2 -> 338
    case 3 -> 1
    case 4 -> 32
    case 5 -> 62
    case 6 -> 93
    case 7 -> 123
    case 8 -> 154
    case 9 -> 185
    case 10 -> 215
    case 11 -> 246
    case 12 -> 276
    case _ -> assert false 0

def weekday_calc (y: i32) (m: i32) (d: i32): i32 =
  let y2 = if m < 3 then y - 1 else y
  in
    (y2 + (y2 / 4) - (y2 / 100) + (y2 / 400) + (month_shift m) + d) % 7

def meetup_dom (y: i32) (m: i32) (w: []u8) (d: []u8): i32 =
  let day = week_limit y m w
  let got = weekday_calc y m day
  let want = weekday_num d
  let shift = if got < want then 7 else 0
  in
    day + want - (got + shift)

def meetup (y: i32) (m: i32) (w: []u8) (d: []u8): []u8 =
  let dom = meetup_dom y m w d
  let buf = replicate 10 '-'
  in
    fill_digits 0 4 y (fill_digits 5 2 m (fill_digits 8 2 dom buf))
