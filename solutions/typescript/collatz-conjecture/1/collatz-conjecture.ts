export function steps(n: number): number {
  if (n < 1 || !Number.isInteger(n))
    throw new Error('Only positive integers are allowed')
  if (n === 1)
    return 0
  return 1 + (n % 2 === 0 ? steps(n / 2) : steps((3 * n) +1))
}