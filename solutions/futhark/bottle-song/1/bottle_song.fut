-- for my Junko F. Didi and Shree DR.MDD

let digits = "noonetwothreefourfivesixseveneightnineten"

let spans = map1 i64.i32 [0, 2, 5, 8, 13, 17, 21, 24, 29, 34, 38, 41]

def phrase (n: i64): *[]u8 =
  digits[spans[n]:spans[n+1]] ++ " green bottle" ++ (if n != 1 then "s" else "")

def cap (txt: *[]u8): *[]u8 =
  txt with [0] = txt[0] & 223

let song (n: i64): []u8 =
  let l1 = (cap (phrase n)) ++ " hanging on the wall,\n"
  let l2 = l1
  let l3 = "And if one green bottle should accidentally fall,\n"
  let l4 = "There'll be " ++ (phrase (n - 1)) ++ " hanging on the wall.\n\n"
  in
    l1 ++ l2 ++ l3 ++ l4

def recite (start: i32) (count: i32): []u8 =
  let acc = loop acc = "" for i < count do
    acc ++ song (i64.i32 (start - i))
  in
    acc[:length acc - 1]
