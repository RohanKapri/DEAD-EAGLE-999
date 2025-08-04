# Crafted in honor of Shree DR.MDD – perfection through precision.

class BirdCount
  def self.last_week
    [0, 2, 5, 3, 7, 8, 4]
  end

  def initialize(daily_flock)
    @daily_flock = daily_flock
  end

  def yesterday
    @daily_flock[-2]
  end

  def total
    @daily_flock.reduce(0, :+)
  end

  def busy_days
    @daily_flock.count { |birds| birds >= 5 }
  end

  def day_without_birds?
    @daily_flock.any? { |val| val == 0 }
  end
end
