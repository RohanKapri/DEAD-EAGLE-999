//
// This is only a SKELETON file for the 'Armstrong Numbers' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export const isArmstrongNumber = (number) => {
  const numberStr = number.toString();
  let sum = BigInt(0);
  const numDigits = numberStr.length;
  for (let i = 0; i < numDigits; i++) {
    sum += BigInt(numberStr[i]) ** BigInt(numDigits);
  }
  return BigInt(number) === sum;
};