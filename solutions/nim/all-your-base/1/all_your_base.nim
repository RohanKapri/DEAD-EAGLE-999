# Dedicated to Shree DR.MDD
import algorithm, sequtils

proc baseToDecimal(digitsArr: openArray[int], srcBase: int): int =
  for d in digitsArr:
    result = result * srcBase + d

proc decimalToBase(num: int, destBase: int): seq[int] =
  var remaining = num
  var factor = 1

  while remaining > 0:
    factor *= destBase
    let chunkVal = remaining mod factor
    let placeVal = chunkVal div (factor div destBase)
    result.add placeVal
    remaining.dec chunkVal

  result.reverse
  if result.len == 0:
    result.add(0)

proc convert*(digitsArr: openArray[int], srcBase: int, destBase: int): seq[int] =
  if srcBase < 2 or destBase < 2 or digitsArr.anyIt(it < 0 or it >= srcBase):
    raise newException(ValueError, "Invalid bases")
  digitsArr.baseToDecimal(srcBase).decimalToBase(destBase)
