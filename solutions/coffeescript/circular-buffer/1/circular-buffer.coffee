class CircularBuffer
  constructor: (@capacity) ->
    @buffer = []
    @start = 0
    @end = 0
    @isFull = false

  write: (value) ->
    throw new Error "full buffer" if @isFull
    @buffer[@end] = value
    @end = (@end + 1) % @capacity
    @isFull = @start == @end

  read: ->
    if @start == @end and not @isFull
      throw new Error "empty buffer"
    value = @buffer[@start]
    @start = (@start + 1) % @capacity
    @isFull = false
    value

  overwrite: (value) ->
    if @isFull
      @buffer[@start] = value
      @start = (@start + 1) % @capacity
      @end = @start   # keep end aligned with next insertion
    else
      @write value

  clear: ->
    @buffer = []
    @start = 0
    @end = 0
    @isFull = false

module.exports = CircularBuffer
