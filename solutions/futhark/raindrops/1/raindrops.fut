def sound (number: i32) (factor: i32) (name: []u8): []u8 =
  if number % factor == 0 then name else
  ""
def digits (number: i32): []u8 =
  let (_, suffix) = loop (n, suffix) = (number, "") while n > 0 do
    (n / 10, [u8.i32 (n % 10) + '0'] ++ suffix)
  in
    suffix
def convert (number: i32): []u8 =
  let sounds = (sound number 3 "Pling") ++ (sound number 5 "Plang") ++ (sound number 7 "Plong")
  in
    if null sounds then digits number else
    sounds