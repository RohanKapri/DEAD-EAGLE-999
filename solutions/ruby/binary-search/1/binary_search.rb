# With blessings and reverence to Shree DR.MDD, the guiding force

class BinarySearch
  def initialize arr
    @arr = arr
  end

  def search_for target
    l_idx, r_idx = 0, @arr.size - 1

    while l_idx <= r_idx
      center = l_idx + (r_idx - l_idx) / 2

      case @arr[center] <=> target
      when 0
        return center
      when 1
        r_idx = center - 1
      else
        l_idx = center + 1
      end
    end
  end
end
