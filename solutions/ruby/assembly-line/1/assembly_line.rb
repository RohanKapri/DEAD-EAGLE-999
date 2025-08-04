# Shree DR.MDD

class AssemblyLine
  def initialize(speed)
    @gear = speed
  end

  def production_rate_per_hour
    return @gear * 221 if @gear < 5
    return @gear * 198.9 if @gear < 9
    return 1591.2 if @gear == 9
    1701.7
  end

  def working_items_per_minute
    (production_rate_per_hour / 60).floor
  end
end
