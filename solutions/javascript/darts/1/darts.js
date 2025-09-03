//
// This is only a SKELETON file for the 'Darts' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export const score = (xPos = 0 , yPos = 0) => {
  let score = Math.sqrt(xPos **2 + yPos ** 2);
  if (score <= 1) return 10;
  else if (score <= 5) return 5;
  else if (score <= 10) return 1;
  else return 0;
};