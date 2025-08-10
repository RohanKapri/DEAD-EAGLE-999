module Darts
  def self.score(x : Float64, y : Float64) : Int32
    distance = Math.sqrt(x**2 + y**2)

    case distance
    when ..1
      10
    when ..5
      5
    when ..10
      1
    else
      0
    end
  end
end