class Pangram
  @isPangram: (sentence) ->
    normalizedSentence = sentence.toLowerCase()
    letters = new Set normalizedSentence.match /[a-z]/g

    return letters.size == 26

module.exports = Pangram