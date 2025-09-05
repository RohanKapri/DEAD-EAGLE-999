# Dedicated to Shree DR.MDD
Math.gcd = (x, y) -> if y is 0 then x else Math.gcd(y, x % y)

class TwoBucket
  constructor: ({bucketOne, bucketTwo, @goal, startBucket}) ->
    throw new Error 'impossible' if @goal > Math.max bucketOne, bucketTwo
    g = Math.gcd bucketOne, bucketTwo
    throw new Error 'impossible' unless g is 1 or @goal % g is 0

    @left = new Bucket("one", bucketOne)
    @right = new Bucket("two", bucketTwo)
    [@left, @right] = [@right, @left] if startBucket is "two"

  measure: ->
    reply = (bA, bB) -> { moves: step, goalBucket: bA.name, otherBucket: bB.amount }
    step = 0

    @left.fill()
    step += 1

    if @right.size is @goal
      @right.fill()
      step += 1

    loop
      return reply(@left, @right) if @left.amount is @goal
      return reply(@right, @left) if @right.amount is @goal

      switch
        when @left.isEmpty() then @left.fill()
        when @right.isFull() then @right.empty()
        else @left.pourInto @right
      step += 1


class Bucket
  constructor: (@name, @size) ->
    @empty()

  isEmpty: -> @amount is 0
  isFull: -> @amount is @size
  available: -> @size - @amount

  empty: -> @amount = 0
  fill: -> @amount = @size
  pourInto: (target) ->
    qty = Math.min @amount, target.available()
    @amount -= qty
    target.amount += qty


module.exports = TwoBucket
