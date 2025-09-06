def egg_count (encoded_value: i32): i32 =
  let (count, _) = loop (count, value) = (0, encoded_value) while value != 0 do
    (count + 1, value ^ (value & (-value)))
  in
    count