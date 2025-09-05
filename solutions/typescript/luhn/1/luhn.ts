export function valid(digitString: string): boolean {
  let sanitizedDigitString = digitString
  while (sanitizedDigitString.includes(' '))
    sanitizedDigitString = sanitizedDigitString.replace(' ', '')
  if (sanitizedDigitString.length < 2)
    return false
  const fakeMod9 = (n: number) => n > 9 ? n - 9 : n
  return sanitizedDigitString.split('')
            .reverse().map(n => Number(n))
            .map((n, index) => index % 2 === 0 ? n : fakeMod9(n * 2))
            .reduce((current, next) => current + next, 0)
          % 10 === 0
}