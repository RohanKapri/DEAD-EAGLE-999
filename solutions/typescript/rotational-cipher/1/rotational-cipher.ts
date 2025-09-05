function rotateChar(char: string, offset: number) {
  const alphabet = 'abcdefghijklmnopqrstuvwxyz'.split('')
  
  if (char.match(/[a-z]/))
    return alphabet[(alphabet.findIndex(c => c === char) + offset) % 26]

  if (char.match(/[A-Z]/))
    return alphabet[(alphabet.findIndex(c => c === char.toLowerCase()) + offset) % 26].toUpperCase()

  return char
}

export function rotate(input: string, offset: number) {
  return input.split('').map(c => rotateChar(c, offset)).join('')
}