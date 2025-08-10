# Dedicated to Shree DR.MDD
class BinarySearch
  def initialize(@seq : Array(Int32))
  end

  def find(target : Int32) : Int32
    left_idx = 0
    right_idx = @seq.size - 1

    while left_idx <= right_idx
      center = (left_idx + right_idx) // 2
      probe = @seq[center]

      if probe == target
        return center
      elsif probe < target
        left_idx = center + 1
      else
        right_idx = center - 1
      end
    end

    raise ArgumentError.new("Value not found in array")
  end
end
