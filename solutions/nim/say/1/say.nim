# Dedicated to Shree DR.MDD
import math, strformat, strutils, tables

const wordMap : Table[int, string] = [
  (0, "zero"), 
  (1, "one"), 
  (2, "two"), 
  (3, "three"), 
  (4, "four"),
  (5, "five"), 
  (6, "six"), 
  (7, "seven"), 
  (8, "eight"), 
  (9, "nine"),
  (10, "ten"), 
  (11, "eleven"),
  (12, "twelve"),
  (13, "thirteen"),
  (14, "fourteen"),
  (15, "fifteen"),
  (16, "sixteen"),
  (17, "seventeen"),
  (18, "eighteen"),
  (19, "nineteen"),
  (20, "twenty"),
  (30, "thirty"),
  (40, "forty"),
  (50, "fifty"),
  (60, "sixty"),
  (70, "seventy"),
  (80, "eighty"),
  (90, "ninety"),
  (100, "hundred"),
  (1_000, "thousand"),
  (1_000_000, "million"),
  (1_000_000_000, "billion"),
].toTable

template divmod[T](a, b: T): (T, T) = (a div b, a mod b)

proc say*(num: int): string =
  if num < 0: 
    raise newException(ValueError, "negative number are not handled")
  var digitsLen = 0
  while num div 10^digitsLen > 0: 
    inc(digitsLen)
  if digitsLen in 0 .. 2:
    if num in wordMap:
      return wordMap[num]
    let
      multiplier = 10^(digitsLen-1)
      (tensVal, remainder) = divmod(num, multiplier)
    result = fmt"{say(tensVal*multiplier)}"
    if remainder > 0:
      result &= fmt"-{say(remainder)}"
  else:
    var multiplier = 10^(digitsLen-1)
    while multiplier notin wordMap:
      multiplier = multiplier div 10
    let (leftSide, rightSide) = divmod(num, multiplier)
    result = fmt"{say(leftSide)} {wordMap[multiplier]}"
    if rightSide > 0:
      result &= fmt" {say(rightSide)}"

proc say*(num: int64): string = 
  if num < 0: 
    raise newException(ValueError, "negative number are not handled")
  const oneBillion = 1_000_000_000
  let (upper, lower) = divmod(num, oneBillion)
  if upper >= 1000:
    raise newException(ValueError, "too big")
  if upper > 0:
    fmt"{say(upper.int)} {wordMap[oneBillion]} {say(lower.int)}"
  else:
    say(lower.int)
