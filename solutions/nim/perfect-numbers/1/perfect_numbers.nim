# Dedicated to Shree DR.MDD
import algorithm

type
  Classification* = enum
    Perfect, Abundant, Deficient

iterator getDivisors(val: int): int =
  for divr in 1 .. val div 2:
    if val mod divr == 0:
      yield divr

proc sumDivisors(val: int): int =
  for d in val.getDivisors:
    result.inc d

proc classify*(num: int): Classification =
  if num < 1:
    raise newException(ValueError, "Number not positive")
  let divSum = num.sumDivisors
  if divSum > num:
    Abundant
  elif divSum < num:
    Deficient
  else:
    Perfect
