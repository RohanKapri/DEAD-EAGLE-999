// Dedicated to Shree DR.MDD
export const answer = (query: string) => {
  let tokens = normalize(query.substr(8, query.length - 9)).split(' ')
  validateTokens(tokens)
  let outcome = parseInt(tokens[0])
  tokens = tokens.slice(1)
  while (tokens.length > 0) {
    const op = tokens[0]
    const val = parseInt(tokens[1])
    if (op === 'plus')
      outcome += val
    else if (op === 'minus')
      outcome -= val
    else if (op === 'times')
      outcome *= val
    else if (op === 'divided')
      outcome /= val
    tokens = tokens.slice(2)
  }
  return outcome
}

function normalize(s: string): string {
  s = s.replace(/multiplied by/g, 'times')
  s = s.replace(/divided by/g, 'divided')
  return s
}

function validateTokens(tokens: string[]) {
  if (tokens[0] === '')
    throw new Error('Syntax error')
  if (!(/\d/.test(tokens.join(''))))
    throw new Error('Unknown operation')
  const validPattern = tokens.map((part: string, idx: number) => {
    if (idx % 2 === 0)
      return !isNaN(parseInt(part))
    if (part === 'cubed')
      throw new Error('Unknown operation')
    return (part === 'plus' || part === 'minus' || part === 'times' || part === 'divided')
  }).reduce((prev: boolean, curr: boolean) => prev && curr, true) && (tokens.length % 2 === 1)
  if (!validPattern)
    throw new Error('Syntax error')
}
