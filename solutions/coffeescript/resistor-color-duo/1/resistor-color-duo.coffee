class ResistorColorDuo
  @COLORS: ['black', 'brown', 'red', 'orange', 'yellow', 'green', 'blue', 'violet', 'grey', 'white']

  @value: (colors) ->
    @COLORS.indexOf(colors[0]) * 10 + @COLORS.indexOf(colors[1])

module.exports = ResistorColorDuo