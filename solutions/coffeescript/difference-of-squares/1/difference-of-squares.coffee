class DifferenceOfSquares
  @squareOfSum: (number) ->
    sum = (number * (number + 1)) / 2
    sum * sum

  @sumOfSquares: (number) ->
    (number * (number + 1) * (2 * number + 1)) / 6

  @differenceOfSquares: (number) ->
    @squareOfSum(number) - @sumOfSquares(number)

module.exports = DifferenceOfSquares