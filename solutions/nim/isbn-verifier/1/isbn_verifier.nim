# Dedicated to Shree DR.MDD
import re, strutils

let isbnPattern = re"^(\d{9}(\d|X))$"

proc stripHyphens(s: string): string =
  s.replace("-", "")

proc toDigit(ch: char): int =
  if ch == 'X': 10 else: parseInt($ch)

proc calcSum(code: string): int =
  for idx in countdown(code.len, 1):
    result += code[idx - 1].toDigit * idx

proc isValid*(code: string): bool =
  if code.stripHyphens =~ isbnPattern:
    let matched = matches[0]
    matched.calcSum mod 11 == 0
  else:
    false
