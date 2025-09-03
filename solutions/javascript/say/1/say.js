export const say = (num) => {
  let basic = ["zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten", "eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen", "seventeen", "eighteen", "nineteen"];
  let decena = ["twenty", "thirty", "forty", "fifty", "sixty", "seventy", "eighty", "ninety"];
  let miles = ["thousand", "million", "billion"];

  if (num < 0 || num > 999999999999) {
    throw new Error('Number must be between 0 and 999,999,999,999.');
  }
  if (num < 20) {
    return basic[num];
  } else if (num < 100) {
    return decena[Math.floor(num / 10) - 2] + (num % 10 === 0 ? '' : '-' + basic[num % 10]);
  } else if (num < 1000) {
    return basic[Math.floor(num / 100)] + " hundred" + (num % 100 === 0 ? '' : ' ' + say(num % 100));
  } else {
    for (let i = miles.length - 1; i >= 0; i--) {
      let divisor = Math.pow(10, (i + 1) * 3);
      if (num >= divisor) {
        return say(Math.floor(num / divisor)) + " "+ miles[i] + (num % divisor === 0? '' : ' ' + say(num % divisor));
      }
    }
    return '';
  }
};