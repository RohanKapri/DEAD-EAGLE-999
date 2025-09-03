//
// This is only a SKELETON file for the 'Pangram' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export const isPangram = (phrase = '') => {
  const ABC='abcdefghijklmnopqrstuvwxyz';
  phrase = phrase.toLowerCase();
  for (let index = 0; index < ABC.length; index++) {
    if (!phrase.includes(ABC[index])) {
       return false;
    }
  }
  return true;
};