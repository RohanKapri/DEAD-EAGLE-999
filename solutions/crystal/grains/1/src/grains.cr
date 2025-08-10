module Grains
  # Calculate the number of grains on a given square
  def self.square(number : Int32) : UInt64
    raise ArgumentError.new("Square must be between 1 and 64") unless number >= 1 && number <= 64
    1_u64 << (number - 1)
  end

  # Calculate the total number of grains on the chessboard
  def self.total : UInt64
    total = 0_u64
    64.times do |i|
      total += 1_u64 << i
    end
    total
  end
end