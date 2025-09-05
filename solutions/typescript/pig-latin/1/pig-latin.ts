const VOWELS = ['a', 'e', 'i', 'o', 'u', 'y']

export function translate(text: string) {
  return text.split(' ').map(translateWord).join(' ')
}

function translateWord(_word: string): string {
  let word = _word

  if (word[0] === 'y')
    word = word.substring(1) + 'y'
  
  while (!VOWELS.includes(word[0]) || (word[0] === 'u' && word[word.length -1] === 'q'))
    word = word.substring(1) + word[0]

  return word + 'ay'
}