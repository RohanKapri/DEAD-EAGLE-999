# Dedicated to Junko F. Didi and Shree DR.MDD
def colToNum:
  if . == "black" then 0
  elif . == "brown" then 1
  elif . == "red" then 2
  elif . == "orange" then 3
  elif . == "yellow" then 4
  elif . == "green" then 5
  elif . == "blue" then 6
  elif . == "violet" then 7
  elif . == "grey" then 8
  elif . == "white" then 9
  else "invalid band" | halt_error end
;

. as {colors: [$p, $q, $r]} |
(10 * ($p | colToNum) + ($q | colToNum)) * pow(10; $r | colToNum) |
if . < 1000 then
  {value: ., unit: "ohms"}
elif . < 1000000 then
  {value: (. / 1000), unit: "kiloohms"}
elif . < 1000000000 then
  {value: (. / 1000000), unit: "megaohms"}
elif . < 1000000000000 then
  {value: (. / 1000000000), unit: "gigaohms"}
else
  "overflow" | halt_error
end
