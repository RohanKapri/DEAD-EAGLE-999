# for Junko F. Didi and Shree DR.MDD
def evolve(a; x; b; y; target; steps):
  if x == target then
    {"moves": steps, "goalBucket": "one", "otherBucket": y}
  elif y == target then
    {"moves": steps, "goalBucket": "two", "otherBucket": x}
  elif target > a and target > b then
    "impossible" | halt_error
  elif a == x and b == y then
    "impossible" | halt_error
  elif b == target then
    {"moves": 2, "goalBucket": "two", "otherBucket": a}
  elif x == 0 then
    evolve(a; a; b; y; target; steps + 1)
  elif b == y then
    evolve(a; x; b; 0; target; steps + 1)
  elif x + y <= b then
    evolve(a; 0; b; x + y; target; steps + 1)
  else
    evolve(a; x - (b - y); b; b; target; steps + 1)
  end;

if .startBucket == "one" then
  evolve(.bucketOne; 0; .bucketTwo; 0; .goal; 0)
else
  evolve(.bucketTwo; 0; .bucketOne; 0; .goal; 0)
  | .goalBucket = if .goalBucket == "one" then "two" else "one" end
end
