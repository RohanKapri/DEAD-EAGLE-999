def command (text: []u8) (condition: i32): []u8 =
  if condition == 0 then ""
  else ", " ++ text
def forwards_commands (code: i32): []u8 =
  (command "wink" (code & 1)) ++ (command "double blink" (code & 2)) ++ (command "close your eyes" (code & 4)) ++ (command "jump" (code & 8))
def backwards_commands (code: i32): []u8 =
  (command "jump" (code & 8)) ++ (command "close your eyes" (code & 4)) ++ (command "double blink" (code & 2)) ++ (command "wink" (code & 1))
def commands (code: i32): []u8 =
  if code & 15 == 0 then "" else
  if code & 16 == 0 then (forwards_commands code)[2:] else
  (backwards_commands code)[2:]