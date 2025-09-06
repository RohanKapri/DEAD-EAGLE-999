def reverse [n] (str: [n]u8): [n]u8 =
  let s = loop s = replicate n '\0' for i < n do
    s with [n - 1 - i] = str[i]
  in
    s