class EliudsEggs
  @eggCount: (displayValue) ->
    binary = displayValue.toString(2)
    count = 0
    for digit in binary
      if digit == '1'
        count++
    count

module.exports = EliudsEggs