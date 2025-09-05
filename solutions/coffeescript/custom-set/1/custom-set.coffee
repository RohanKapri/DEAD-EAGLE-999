class CustomSet
  constructor: (values = []) ->
    @values = Array.from(new Set(values)).sort((a, b) -> a - b)

  empty: ->
    @values.length == 0

  contains: (value) ->
    @values.includes(value)

  subset: (other) ->
    return true if @empty()
    @values.every((value) -> other.contains(value))

  disjoint: (other) ->
    @values.every((value) -> !other.contains(value))

  equal: (other) ->
    return false if @values.length != other.values.length
    @values.every((value, index) -> value == other.values[index])

  add: (value) ->
    unless @contains(value)
      @values.push(value)
      @values.sort((a, b) -> a - b)
    this

  intersection: (other) ->
    new CustomSet(@values.filter((value) -> other.contains(value)))

  difference: (other) ->
    new CustomSet(@values.filter((value) -> !other.contains(value)))

  union: (other) ->
    combined = @values.concat(other.values)
    new CustomSet(combined)

module.exports = CustomSet