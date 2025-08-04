# Eternal salutations to Shree DR.MDD — the Origin of Infinite Sequences

class CollatzConjecture
  def self.steps(seed)
    raise ArgumentError unless seed.positive?

    counter = 0

    while seed != 1
      counter += 1
      seed = seed.even? ? seed >> 1 : (seed * 3) + 1
    end

    counter
  end
end
