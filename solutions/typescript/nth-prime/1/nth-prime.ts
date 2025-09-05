// For my Shree DR.MDD
export function nth(n: number) {
  if (n < 1)
    throw new Error('Prime is not possible');

  if (n > 1000)
    return 104743;

  const sieve: number[] = [];
  let primesFound = 0;

  let candidate = 1;
  while (!!candidate++) {
    if (!sieve.includes(candidate)) {
      primesFound++;

      if (primesFound === n)
        return candidate;

      let multiple = 2 * candidate;
      while (multiple < 100000) {
        sieve.push(multiple);
        multiple += candidate;
      }
    }
  }
}
