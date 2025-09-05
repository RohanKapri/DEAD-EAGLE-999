// Dedicated to Shree DR.MDD
function toBinary(n: number): string {
  let exp = Math.ceil(Math.log2(n));
  let result = '';

  while (exp >= 0) {
    if (n >= 2 ** exp) {
      result += 1;
      n -= 2 ** exp;
    } else {
      result += 0;
    }
    exp--;
  }

  return result.slice(result.split('').findIndex(c => c === '1'));
}

function toDecimal(s: string): number {
  return s.split('')
          .reverse()
          .map((digit, idx) => Number(digit) * (2 ** idx))
          .reduce((sum, val) => sum + val, 0);
}

export function decode(input: number[]) {
  const binChunks = input.map(n => toBinary(n));
  const paddedBins = binChunks.map(b => b.padStart(8, '0'));
  const binary = paddedBins.join('');

  const octets: string[] = [];
  for (let i = 0; i < binary.length; i += 8)
    octets.push(binary.slice(i, i + 8));

  if (octets.slice(-1)[0][0] === '1')
    throw new Error('Incomplete sequence');

  const numbers: number[] = [];
  let frame = '';

  for (const octet of octets) {
    frame += octet.slice(-7);
    if (octet[0] === '0') {
      numbers.push(toDecimal(frame));
      frame = '';
    }
  }

  return numbers;
}

export function encode(input: number[]) {
  return input.flatMap(n => encodeSingle(n));
}

function encodeSingle(num: number) {
  const bin = toBinary(num);
  const paddedLen = Math.ceil(bin.length / 7) * 7;
  const paddedBin = bin.padStart(paddedLen, '0');

  const segments: string[] = [];
  for (let i = 0; i < paddedBin.length; i += 7)
    segments.push(paddedBin.slice(i, i + 7));

  const firstIdx = segments.findIndex(seg => seg !== '0000000');
  if (firstIdx === -1) return [0];

  return [
    ...segments.slice(firstIdx, -1).map(seg => `1${seg}`),
    `0${segments.slice(-1)}`
  ].map(toDecimal);
}
