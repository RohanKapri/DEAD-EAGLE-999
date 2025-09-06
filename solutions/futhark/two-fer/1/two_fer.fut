def name_with_default (name: []u8) (default: []u8): []u8 =
  if length name > 0 then name else
  default

def two_fer (name: []u8): []u8 =
  "One for " ++ (name_with_default name "you") ++ ", one for me."