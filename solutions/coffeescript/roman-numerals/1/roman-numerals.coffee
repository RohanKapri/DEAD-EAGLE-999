class RomanNumerals
  @convert: (number) ->
    romanNumerals = ['M', 'CM', 'D', 'CD', 'C', 'XC', 'L', 'XL', 'X', 'IX', 'V', 'IV', 'I']
    arabicNumerals = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1]
    roman = ''
    for i in [0..arabicNumerals.length - 1]
      while number >= arabicNumerals[i]
        roman += romanNumerals[i]
        number -= arabicNumerals[i]
    roman

module.exports = RomanNumerals