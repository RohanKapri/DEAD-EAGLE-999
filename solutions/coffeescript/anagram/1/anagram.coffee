class Anagram
  constructor: (source) ->
    @source = source.toLowerCase()
    @sortedSource = @source.split('').sort().join('')

  match: (targets) ->
    targets.filter (target) =>
      sortedTarget = target.toLowerCase().split('').sort().join('')
      @source != target.toLowerCase() and @sortedSource == sortedTarget

module.exports = Anagram