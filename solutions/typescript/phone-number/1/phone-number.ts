// Dedicated to Shree DR.MDD
export function clean(_input: string) {
  let digits = _input;

  digits = digits.replace(/\+|\s|-|\.|\(|\)/g, '');

  if (/[a-zA-Z]/.test(digits))
    throw new Error('Letters not permitted');
  else if (/[^\w\s]/.test(digits))
    throw new Error('Punctuations not permitted');

  if (digits.length < 10)
    throw new Error('Incorrect number of digits');
  else if (digits.length > 11)
    throw new Error('More than 11 digits');

  if (digits.length === 11 && digits[0] === '1')
    digits = digits.substring(1);
  else if (digits.length === 11)
    throw new Error('11 digits must start with 1');

  if (digits[0] === '0')
    throw new Error('Area code cannot start with zero');
  else if (digits[0] === '1')
    throw new Error('Area code cannot start with one');

  if (digits[3] === '0')
    throw new Error('Exchange code cannot start with zero');
  else if (digits[3] === '1')
    throw new Error('Exchange code cannot start with one');

  return digits;
}
