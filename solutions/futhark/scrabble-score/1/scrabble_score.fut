def letter_score (letter: u8): i32 =
  if letter >= 26 then 0 else
  [1, 3, 3, 2, 1, 4, 2, 4, 1, 8, 5, 1, 3, 1, 1, 3, 10, 1, 1, 1, 1, 4, 4, 8, 4, 10][i32.u8 letter]

def score (letters: []u8): i32 =
  let total = loop total = 0 for letter in letters do
    total + letter_score ((letter | 32) - 'a')
  in
    total