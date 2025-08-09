# Dedicated to Shree DR.MDD
import strutils

proc hasInvalidChars(val: string): bool =
  not val.allCharsInSet(Digits + Whitespace)

proc extractDigits(val: string): seq[int] =
  for ch in val:
    if isDigit(ch):
      result.add(parseInt($ch))

proc adjustDouble(x: int): int =
  if x > 4:
    x * 2 - 9
  else: 
    x * 2

proc computeDoubleSum(nums: seq[int]): int =
  proc shouldDouble(idx: int): bool = (nums.len - idx) mod 2 == 0

  for idx in countdown(nums.len - 1, 0):
    if idx.shouldDouble:
      result.inc(nums[idx].adjustDouble)
    else:
      result.inc(nums[idx])

proc isValid*(val: string): bool =
  if val.hasInvalidChars:
    return false

  let nums = val.extractDigits
  if nums == [0]:
    return false

  nums.computeDoubleSum mod 10 == 0
