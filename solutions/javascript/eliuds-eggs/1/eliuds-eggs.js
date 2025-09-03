//
// This is only a SKELETON file for the 'Eliud's Eggs' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export const eggCount = (displayValue) => {
  let eggs = 0;
  while (displayValue != 0) {
      eggs += displayValue % 2;
      displayValue /= 2;
      displayValue = Math.floor(displayValue);
  }
  return eggs;
};