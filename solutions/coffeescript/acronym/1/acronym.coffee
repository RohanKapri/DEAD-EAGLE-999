class Acronym
  @abbreviate: (phrase) ->
    phrase.split(/[\s_-]+/).filter(Boolean).map((word) -> word[0].toUpperCase()).join('')

module.exports = Acronym