export function encode(plainText: string): string {
  const nonLetters = [' ', ',', '.']
  const encoded = plainText.split('').filter(l => !nonLetters.includes(l)).map(encodeLetter)
  const result = []
  for (let i = 0; i < encoded.length; i += 5) {
    result.push(encoded.slice(i, i + 5))
  }
  return result.map(a => a.join('')).join(' ')
}
export function decode(cipherText: string): string {
   const nonLetters = [' ']
  return cipherText.split('').filter(l => !nonLetters.includes(l)).map(encodeLetter).join('')
}
function encodeLetter(letter: string): string {
  letter = letter.toLowerCase()
  const alphabet = 'abcdefghijklmnopqrstuvwxyz'.split('')
  if(alphabet.includes(letter)) {
    return alphabet[(alphabet.length - 1) - alphabet.indexOf(letter)]
  }
  return letter
}
