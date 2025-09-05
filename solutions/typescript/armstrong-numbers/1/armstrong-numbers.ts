export function isArmstrongNumber(number: number): boolean {
  const digits = number.toString().split('').map(d => BigInt(d))
  const numberOfDigits = BigInt(digits.length)

  return BigInt(number) === digits.reduce((sum, digit) => sum + (digit ** numberOfDigits), BigInt(0))
}