def is_pangram (sentence: []u8): bool =
  let seen = loop seen = 0 for letter in sentence do
    let index = (letter | 32) - 'a'
    in
      if index >= 26 then seen else
      seen | (1 << i32.u8 index)
  in
    seen == 0x3ffffff