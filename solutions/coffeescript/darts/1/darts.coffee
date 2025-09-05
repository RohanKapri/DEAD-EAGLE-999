class Darts
  @score: (x, y) ->
    distance = Math.sqrt(x * x + y * y)
    if distance > 10
      0
    else if distance > 5
      1
    else if distance > 1
      5
    else
      10

module.exports = Darts