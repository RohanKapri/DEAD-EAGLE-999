def is_isogram (phrase: []u8): bool =
  let (result, _) = loop (result, seen) = (true, 0) for ch in phrase do
    let letter = (ch | 32) - 'a'
    in
      if letter >= 26 then (result, seen) else
      let update = 1 << i32.u8 letter in
        if (seen & update) != 0 then (false, seen) else
        (result, seen | update)
  in
    result