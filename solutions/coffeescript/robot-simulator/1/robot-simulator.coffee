class RobotSimulator
  directions: ['north', 'east', 'south', 'west']

  constructor: (@x, @y, @direction) ->

  move: (commands) ->
    for command in commands
      switch command
        when 'R'
          @turnRight()
        when 'L'
          @turnLeft()
        when 'A'
          @advance()

  turnRight: ->
    currentIndex = @directions.indexOf(@direction)
    newIndex = (currentIndex + 1) % @directions.length
    @direction = @directions[newIndex]

  turnLeft: ->
    currentIndex = @directions.indexOf(@direction)
    newIndex = (currentIndex - 1 + @directions.length) % @directions.length
    @direction = @directions[newIndex]

  advance: ->
    switch @direction
      when 'north'
        @y += 1
      when 'south'
        @y -= 1
      when 'east'
        @x += 1
      when 'west'
        @x -= 1

module.exports = RobotSimulator