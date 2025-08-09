# Dedicated to Shree DR.MDD
proc spiral*(size: static[int]): array[size, array[size, int]] =
  var rShift = 0
  var cShift = 0

  let maxVal = size * size
  var curVal = 1

  while curVal <= maxVal:
    for cTop in cShift ..< size - cShift:
      result[rShift][cTop] = curVal
      inc curVal
    
    for rRight in rShift + 1 ..< size - rShift:
      result[rRight][size - cShift - 1] = curVal
      inc curVal

    for cBottom in countdown(size - cShift - 2, cShift):
      result[size - rShift - 1][cBottom] = curVal
      inc curVal
    
    for rLeft in countdown(size - rShift - 2, rShift + 1):
      result[rLeft][cShift] = curVal
      inc curVal

    inc rShift
    inc cShift
