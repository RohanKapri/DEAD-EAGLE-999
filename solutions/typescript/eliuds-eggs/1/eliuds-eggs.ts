export const eggCount = (displayValue: number): number => {
  let numberOfEggs = 0
  let highestPowerOfTwo = Math.ceil(Math.log(displayValue) / Math.log(2))
  let remainder = displayValue
  
  while (remainder > 0) {
    const binaryFactor = 2 ** highestPowerOfTwo
    if (remainder >= binaryFactor) {
      numberOfEggs += 1
      remainder -= binaryFactor
    }
    highestPowerOfTwo -= 1
  }
  
  return numberOfEggs
}