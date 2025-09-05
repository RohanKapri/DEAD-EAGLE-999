const alphabet = 'abcdefghijklmnopqrstuvwxyz'.toUpperCase()

export function makeDiamond(character: string): string {
  const charIndex = alphabet.split('').findIndex(c => c === character)

  if (charIndex === 0)
    return 'A\n'

  const top = makeDiamond(alphabet[charIndex - 1]).split('\n').map(row => ` ${row} `).slice(0, charIndex)
  const bottom = [...top].reverse()

  console.log(top)

  return [
    ...top,
    character + ' '.repeat((charIndex * 2) - 1) + character,
    ...bottom
  ].join('\n') + '\n'
}