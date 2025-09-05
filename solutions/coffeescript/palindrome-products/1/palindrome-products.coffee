module.exports = class PalindromeProducts
  constructor: (args) -> 
    [@max, @min] = [args.maxFactor, args.minFactor ? 1]
    @sml = @lrg = value: null, factors: []
    @calculated = false
  smallest: -> @find(); @sml
  largest: -> @find(); @lrg
  find: ->
    throw "min must be <= max" if @min > @max
    for i in [@min..@max]
      for j in [i..@max]
        continue unless isPalindrome(prod = i * j)
        if prod < @sml.value || not @sml.value
          @sml = value: prod, factors: [[i,j]]
        else if prod is @sml.value
          @sml.factors.push [i,j]
        else if prod is @lrg.value
          @lrg.factors.push [i,j]
        else if prod > @lrg.value
          @lrg = value: prod, factors: [[i,j]]
    @calculated = true
isPalindrome = (num) ->
  str = num.toString()
  for i in [0...str.length / 2]
    return false if str[i] != str[str.length - 1 - i]
  true