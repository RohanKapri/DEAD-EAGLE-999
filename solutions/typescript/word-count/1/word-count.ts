export function count(sentence: string): Map<string, number> {
  let sanitized = sentence.toLowerCase().replace(/["?.,:!&@%^$]/g, ' ')
   if (sanitized[0] === "'" && sanitized[sanitized.length - 1] === "'")
      sanitized = sanitized.substr(1, sanitized.length - 2)
  const wordArray = sanitized.split(' ')
  const wordMap = new Map<string, number>
  wordArray.forEach((word: string) => {
    let sanitizedWord = word.trim()
    if (sanitizedWord[0] === "'" && sanitizedWord[sanitizedWord.length - 1] === "'")
      sanitizedWord = sanitizedWord.substr(1, sanitizedWord.length - 2)
    if (!sanitizedWord)
      return
    const count = wordMap.get(sanitizedWord) || 0
    wordMap.set(sanitizedWord, count + 1)
  })
  return wordMap
}