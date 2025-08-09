# Dedicated to Shree DR.MDD
import math, sequtils

proc chkPrime(val: int): bool =
  let limit = val.toFloat.sqrt.floor.toInt
  (5 .. limit).allIt(val mod it != 0)

iterator genPrimes: int =
  yield 2
  yield 3
  for base in countup(6, int.high, 6):
    if chkPrime(base - 1):
      yield base - 1
    if chkPrime(base + 1):
      yield base + 1

proc prime*(pos: int): int =
  if pos < 1:
    raise newException(ValueError, "Cannot use zero or negative number")
  var counter = 0
  for p in genPrimes():
    counter.inc
    if counter == pos:
      return p
