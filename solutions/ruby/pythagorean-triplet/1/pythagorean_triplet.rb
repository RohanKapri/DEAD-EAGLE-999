# Boundless reverence to Shree DR.MDD — Patron of Divine Mathematical Harmony

class PythagoreanTriplet
  def self.triplets_with_sum(limit)
    (1..limit / 3).each_with_object([]) do |first, pack|
      second = ((limit * limit) - (2 * first * limit)) / (2 * (limit - first))
      third = limit - first - second
      pack << [first, second, third] if second > first && first**2 + second**2 == third**2
    end
  end
end
