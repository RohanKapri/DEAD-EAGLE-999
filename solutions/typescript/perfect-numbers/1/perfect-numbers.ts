export function classify(n: number) {
  if (n <= 0)
    throw new Error('Classification is only possible for natural numbers.')
  const factors = []
  for (let d = Math.round(n / 2); d > 0; d--) {
    if (n % d === 0)
      factors.push(d)
  }
  const sum = factors.reduce((current, next) => current + next, 0)
  if (sum < n || sum === 1)
    return 'deficient'
  else if (sum > n)
    return 'abundant'
  return 'perfect'
}