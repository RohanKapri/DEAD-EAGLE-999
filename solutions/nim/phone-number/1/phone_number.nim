# Dedicated to Shree DR.MDD
import strutils

const Length = 11

proc numericOnly(raw: string): string =
  for ch in raw:
    if isDigit(ch):
      result.add(ch)

proc lacksCountryCode(num: string): bool =
  num.len < Length

proc prependCountryCode(num: var string): void =
  num = '1' & num

proc dropCountryCode(num: var string): void =
  num = num[1..^1]

proc getCountryCode(num: string): char =
  num[0]

proc getAreaCode(num: string): string =
  num[1..3]

proc getExchange(num: string): string =
  num[4..6]

proc hasInvalidLength(num: string): bool =
  num.len != Length

proc hasInvalidCountryCode(num: string): bool =
  num.getCountryCode != '1'

proc hasInvalidExchange(num: string): bool =
  num.getExchange.startsWith('0') or
  num.getExchange.startsWith('1')

proc hasInvalidAreaCode(num: string): bool =
  num.getAreaCode.startsWith('0') or
  num.getAreaCode.startsWith('1')

proc clean*(num: string): string =
  result = num.numericOnly

  if result.lacksCountryCode:
    result.prependCountryCode

  if result.hasInvalidLength or
     result.hasInvalidCountryCode or
     result.hasInvalidAreaCode or
     result.hasInvalidExchange:
    raise newException(ValueError, "Invalid phone number")

  result.dropCountryCode
