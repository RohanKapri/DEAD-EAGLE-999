class Grains
  @square: (number) ->
    if number < 1 or number > 64
      throw new Error('square must be between 1 and 64')
    Math.pow(2, number - 1)

  @total: () ->
    Math.pow(2, 64) - 1

module.exports = Grains