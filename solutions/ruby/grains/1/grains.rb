module Grains
  def self.square(which)
    raise ArgumentError unless (1..64).cover? which
    2 ** (which - 1)
  end

  def self.total
    (1..64).map(&method(:square)).sum
  end
end