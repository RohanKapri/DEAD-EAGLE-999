def chunk [n] (phrase: [n]u8): []u8 =
  let (i, a) = loop (i, a) = (0, replicate (n * 6 / 5) ' ') for c in phrase do
    if i % 6 == 5 then (i + 2, a with [i + 1] = c) else
    (i + 1, a with [i] = c)
  in
    a[0:i]
def process [n] (phrase: [n]u8): []u8 =
  let (i, a) = loop (i, a) = (0, replicate n '\0') for c in phrase do
    let number = c - '0'
    let letter = (c | 32) - 'a'
    in
      if number < 10 then (i + 1, a with [i] = c) else
      if letter < 26 then (i + 1, a with [i] = 'a' + 25 - letter) else
      (i, a)
  in
    a[0:i]
def encode [n] (phrase: [n]u8): []u8 =
  phrase
  |> process
  |> chunk
def decode [n] (phrase: [n]u8): []u8 =
  phrase
  |> process