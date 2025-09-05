const isLower = (char: string) => char === char.toLowerCase() && char !== char.toUpperCase()
export function parse (phrase: string) {
  let acronym = ''
  for (let i = 0; i < phrase.length; i++) {
    if (i === 0 || phrase[i - 1] === ' ' || phrase[i - 1] === '-' || (isLower(phrase[i - 1]) && !isLower(phrase[i])))
      acronym += phrase[i].toUpperCase()
  }
  return acronym.replace(/ /g, '').replace(/-/g, '').replace(/,/g, '')
}