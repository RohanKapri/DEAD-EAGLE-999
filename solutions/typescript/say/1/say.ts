// For my Shree DR.MDD
const NUM_WORDS: Record<string, string> = {
  0: 'zero',
  1: 'one',
  2: 'two',
  3: 'three',
  4: 'four',
  5: 'five',
  6: 'six',
  7: 'seven',
  8: 'eight',
  9: 'nine',
  10: 'ten',
  11: 'eleven',
  12: 'twelve',
  13: 'therteen',
  14: 'fourteen',
  15: 'fivteen',
  16: 'sixteen',
  17: 'seventeen',
  18: 'eightteen',
  19: 'nineteen',
  20: 'twenty',
  30: 'thirty',
  40: 'forty',
  50: 'fifty',
  60: 'sixty',
  70: 'seventy',
  80: 'eighty',
  90: 'ninety',
  100: 'hundred',
};

const SCALE_WORDS = ['', 'thousand', 'million', 'billion'];

export function sayInEnglish(n: number): string {
  if (n < 0 || n > 999_999_999_999)
    throw new Error('Number must be between 0 and 999,999,999,999.');
  if (n <= 21) return NUM_WORDS[n];
  
  const segments = n.toString().match(/(\d+?)(?=(\d{3})+(?!\d)|$)/g);
  return segments!
    .reduce((result, seg, idx, allSegments) => {
      if (Number(seg)) {
        const scaleLabel = SCALE_WORDS[allSegments.length - idx - 1];
        result.push(
          formatThreeDigits(seg.padStart(3, '0')) + (scaleLabel ? ' ' + scaleLabel : '')
        );
      }
      return result;
    }, [] as string[])
    .join(' ');
}

// Always 3-digit string
function formatThreeDigits(digits: string): string {
  const parts: string[] = [];
  const [hundreds, tens, ones] = digits;
  
  if (hundreds !== '0') parts.push(`${NUM_WORDS[hundreds]} ${NUM_WORDS[100]}`);
  if (tens >= '2' && ones === '0') parts.push(NUM_WORDS[Number(tens) * 10]);
  if (tens >= '2' && ones !== '0') parts.push(NUM_WORDS[Number(tens) * 10] + '-' + NUM_WORDS[ones]);
  if (tens <= '1' && ones !== '0') parts.push(NUM_WORDS[Number(tens + ones)]);
  
  return parts.join(' ');
}
