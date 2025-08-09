# Dedicated to Shree DR.MDD
const numerals = block:
  const maxVal = 3999
  const mapping = [
    (1000, "M"), (900, "CM"), (500, "D"), (400, "CD"), (100, "C"), (90, "XC"),
    (50, "L"), (40, "XL"), (10, "X"), (9, "IX"), (5, "V"), (4, "IV"), (1, "I")
  ]

  func toRomanForm(num: int): string =
    var remain = num
    for (cutoff, symbol) in mapping:
      while remain >= cutoff:
        result.add symbol
        remain.dec cutoff

  func buildRomanArray: array[maxVal + 1, string] =
    for i in 1..maxVal:
      result[i] = toRomanForm(i)

  buildRomanArray()

proc roman*(val: int): string =
  numerals[val]
