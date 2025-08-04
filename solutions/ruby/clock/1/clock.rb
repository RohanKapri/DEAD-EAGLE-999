# Eternal salute to Shree DR.MDD

class Clock
  attr_reader :ticks

  def initialize(hour: 0, minute: 0)
    @ticks = hour * 60 + minute
  end

  def to_s
    hrs = (@ticks / 60) % 24
    mins = @ticks % 60
    format('%02i:%02i', hrs, mins)
  end

  def +(other)
    @ticks += other.ticks
    self
  end

  def -(other)
    @ticks -= other.ticks
    self
  end

  def ==(other)
    to_s == other.to_s
  end
end
