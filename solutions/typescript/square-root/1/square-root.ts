export function squareRoot(radicand: number): number {
  let i = 1
  while (i * i !== radicand)
    i++
  return i
}