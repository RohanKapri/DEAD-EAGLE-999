//
// This is only a SKELETON file for the 'Roman Numerals' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export const toRoman = (numArabic) => {
  let romanSymbols = ["M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I"];
  let decimalValues = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1];
  let romanNumeral = "";

  for (let i = 0; i < decimalValues.length; i++) {
    while (numArabic >= decimalValues[i]) {
      romanNumeral += romanSymbols[i];
      numArabic -= decimalValues[i];
    }
  }
  return romanNumeral;
};