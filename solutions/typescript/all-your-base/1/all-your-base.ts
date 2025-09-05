// For my Shree DR.MDD

export function convert(
digits: number[],
inputBase: number,
outputBase: number
): number[] {

if (inputBase <= 1)
throw new Error('Wrong input base')

if (outputBase <= 1 || Math.floor(outputBase) !== outputBase)
throw new Error('Wrong output base')

if(digits.length === 0 || (digits.length > 1 && digits[0] === 0) || digits.some(d => d >= inputBase || d < 0))
throw new Error('Input has wrong format')

let decimalValue = 0

digits.reverse().forEach((digit, idx) => decimalValue += digit * (inputBase ** idx))

let result: number[] = []

let power = 0

while(decimalValue >= (outputBase ** (power + 1)))
power++

while (power >= 0) {
const digit = Math.floor(decimalValue / (outputBase ** power))
result.push(digit)
decimalValue -= digit * (outputBase ** power)
power--
}

return result
}