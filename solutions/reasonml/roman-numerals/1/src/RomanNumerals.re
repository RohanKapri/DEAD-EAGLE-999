let units = [|"", "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX"|];
let tens = [|"", "X", "XX", "XXX", "XL", "L", "LX", "LXX", "LXXX", "XC"|];
let hundreds = [|"", "C", "CC", "CCC", "CD", "D", "DC", "DCC", "DCCC", "CM"|];
let thousands = [|"", "M", "MM", "MMM"|];

let toRoman = n => {
  let thousand = thousands[n / 1000];
  let hundred = hundreds[n mod 1000 / 100];
  let ten = tens[n mod 100 / 10];
  let unit = units[n mod 10];
  
  {j|$thousand$hundred$ten$unit|j};
};