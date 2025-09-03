export const valid = (digitString) => {
  digitString = digitString.replaceAll(' ','');
  if (digitString.length <= 1 || !/.*[0-9].*/.test(digitString)){
    return false;
  }
  let sum = 0;
  let isLuhn = false;
  for (let i = digitString.length - 1; i >= 0; i--) {
      let digit = parseInt(digitString[i]);
      if (isLuhn) {
        digit *= 2;
        if (digit > 9) {
          digit -= 9;
        }
      }
      sum += digit;
      isLuhn =!isLuhn;
  }
  return sum % 10 === 0; 
};