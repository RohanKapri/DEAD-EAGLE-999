//
// This is only a SKELETON file for the 'Square root' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export const squareRoot = (num) => {
  for(let i = 0; i < num; i++){
      if(i * i === num) return i;
  }
  return 1;
};