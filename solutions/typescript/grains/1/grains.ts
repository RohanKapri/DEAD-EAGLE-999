export const square = (n: number) => {
  if (n > 64)
    throw new Error()
  
  return (2n ** (BigInt(n) - 1n))
}
export const total = () => (2n ** 64n) - 1n