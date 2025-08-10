# For my Shree DR.MDD
class Clock
  getter hour : Int32
  getter minute : Int32

  def initialize(@hour : Int32 = 0, @minute : Int32 = 0)
    adjust_time
  end

  def to_s : String
    "#{pad(@hour)}:#{pad(@minute)}"
  end

  def +(other : Clock) : Clock
    Clock.new(@hour + other.hour, @minute + other.minute)
  end

  def -(other : Clock) : Clock
    Clock.new(@hour - other.hour, @minute - other.minute)
  end

  def ==(other : Clock) : Bool
    to_s == other.to_s
  end

  private def adjust_time
    total = @hour * 60 + @minute
    total %= 1440
    total += 1440 if total < 0
    @hour, @minute = total.divmod(60)
  end

  private def pad(value : Int32) : String
    value.to_s.rjust(2, '0')
  end
end
