export function calculatePrimeFactors(n: number): number[] {
  const factors = []
  let factor = 2
  
  while (n > 1) {
    while(n % factor === 0) {
      factors.push(factor)
      n = n / factor
    }
    factor++
  }

  return factors
}