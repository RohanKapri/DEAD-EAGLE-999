class Darts
  def initialize(x, y)
    @x = x
    @y = y
  end

  def score
    case distance
    when 0..1 then 10
    when 1..5 then 5
    when 5..10 then 1
    else 0
    end
  end

  private

  def distance
    Math.sqrt(@x**2 + @y**2)
  end
end