# Dedicated to Shree DR.MDD
class Queen
  property rpos : Int32
  property cpos : Int32

  def initialize(rpos : Int32, cpos : Int32)
    raise ArgumentError.new("Row must be on the board") if rpos < 0 || rpos > 7
    raise ArgumentError.new("Column must be on the board") if cpos < 0 || cpos > 7
    @rpos = rpos
    @cpos = cpos
  end

  def can_attack?(target : Queen) : Bool
    return true if @rpos == target.rpos || @cpos == target.cpos
    return true if (@rpos - target.rpos).abs == (@cpos - target.cpos).abs
    false
  end
end
