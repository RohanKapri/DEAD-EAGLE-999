class WordCount
  constructor: (phrase) ->
    @phrase = phrase

  count: ->
    @phrase
    .toLowerCase()
    .match(/\b[\w']+\b/g)
    .reduce((counts, m) ->
      counts[m] = counts[m] + 1 or 1
      counts
    , {})

module.exports = WordCount