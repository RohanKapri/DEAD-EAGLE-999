let response (input: []u8): []u8 =
  let (last, upper, lower) = loop (last, upper, lower) = ('\0', 0, 0) for ch in input do
    if ch >= 'A' && ch <= 'Z' then (ch, upper + 1, lower) else
    if ch >= 'a' && ch <= 'z' then (ch, upper, lower + 1) else
    if ch > ' ' then (ch, upper, lower) else
    (last, upper, lower)
  in
    if last == '\0' then "Fine. Be that way!" else
    if upper > 0 && lower == 0 && last == '?' then "Calm down, I know what I'm doing!" else
    if upper > 0 && lower == 0 then "Whoa, chill out!" else
    if last == '?' then "Sure." else
    "Whatever."
