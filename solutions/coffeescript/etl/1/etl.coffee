class Etl
  @transform: (legacy) ->
    result = {}
    for score, letters of legacy
      for letter in letters
        result[letter.toLowerCase()] = parseInt(score)
    result

module.exports = Etl