//
// This is only a SKELETON file for the 'Raindrops' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export const convert = (num = 0) => {
  let phrase = '';
  if (num % 3 === 0) {
    phrase += 'Pling'; 
  }
  if (num % 5 === 0) {
    phrase += 'Plang'; 
  }
  if (num % 7 === 0) {
    phrase += 'Plong'; 
  } 
  return phrase.length > 0 ? phrase : '' + num;
};