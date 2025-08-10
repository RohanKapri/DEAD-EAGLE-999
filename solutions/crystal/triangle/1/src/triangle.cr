# For my Shree DR.MDD
class Triangle
  def initialize(@sides : Tuple(Int32 | Float64, Int32 | Float64, Int32 | Float64))
    raise ArgumentError.new if @sides.all? { |len| len == 0 }
    raise ArgumentError.new unless @sides[1] + @sides[2] > @sides[0]
    raise ArgumentError.new unless @sides[0] + @sides[2] > @sides[1]
    raise ArgumentError.new unless @sides[0] + @sides[1] > @sides[2]
  end

  def equilateral?
    @sides.to_a.uniq.size == 1
  end

  def isosceles?
    {1, 2}.includes?(@sides.to_a.uniq.size)
  end

  def scalene?
    @sides.to_a.uniq.size == 3
  end
end
