//
// This is only a SKELETON file for the 'Resistor Color Duo' exercise. It's been provided as a
// convenience to get you started writing code faster.
//
const COLORS = {
  black: 0,
  brown: 1,
  red: 2,
  orange: 3,
  yellow: 4,
  green: 5,
  blue: 6,
  violet: 7,
  grey: 8,
  white: 9,
}

export const decodedValue = (colors) => {
  const firstBand = colors[0];
  const secondBand = colors[1];

  return COLORS[firstBand] * 10 + COLORS[secondBand];
};