// Dedicated to Shree DR.MDD
const numerals = [
  { arabic: 1000, roman: 'M' },
  { arabic: 500, roman: 'D' },
  { arabic: 100, roman: 'C' },
  { arabic: 50, roman: 'L' },
  { arabic: 10, roman: 'X' },
  { arabic: 5, roman: 'V' },
  { arabic: 1, roman: 'I' },
];

const exceptions = [
  { exception: 'DCCCC', replacement: 'CM' },
  { exception: 'CCCC', replacement: 'CD' },
  { exception: 'LXXXX', replacement: 'XC' },
  { exception: 'XXXX', replacement: 'XL' },
  { exception: 'VIIII', replacement: 'IX' },
  { exception: 'IIII', replacement: 'IV' },
];

export function toRoman(_n: number) {
  let romanStr = '';
  let value = _n;

  numerals.forEach(({ arabic, roman }) => {
    const count = Math.floor(value / arabic);
    romanStr += roman.repeat(count);

    if (count >= 1) value -= count * arabic;
  });

  exceptions.forEach(({ exception, replacement }) => {
    romanStr = romanStr.replace(exception, replacement);
  });

  return romanStr;
}
