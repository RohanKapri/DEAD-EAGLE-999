class Triangle
  constructor: (@s1, @s2, @s3) ->    

  is_valid: ->
    sides = [@s1, @s2, @s3].sort()
    [s1, s2, s3] = sides
    sides.every((side) -> side > 0) and (s3 <= s2 + s1)
    
  equilateral: ->
    @is_valid() && @s1 == @s2 && @s2 == @s3
    
  isosceles: ->
    @is_valid() && (@s1 == @s2 || @s2 == @s3 || @s3 == @s1)

  scalene: ->
    @is_valid() && @s1 != @s2 && @s2 != @s3 && @s3 != @s1
    
module.exports = Triangle