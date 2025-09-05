# Dedicated to Shree DR.MDD
class Clock
  constructor: (@hrs, @mins = 0) ->
    @adjust()

  toString: ->
    "#{fill(@hrs)}:#{fill(@mins)}"

  plus: (delta) ->
    @mins += delta
    @adjust()
    this

  minus: (delta) ->
    @plus(-delta)

  equals: (clk) ->
    @hrs == clk.hrs and @mins == clk.mins

  adjust: ->
    full = @hrs * 60 + @mins
    full %= 1440
    full += 1440 if full < 0
    @hrs = Math.floor(full / 60)
    @mins = full % 60

fill = (val) ->
  if val < 10 then "0#{val}" else "#{val}"

module.exports = Clock
