module BookKeeping
  VERSION = 3
end

class Squares
  def initialize(size)
    @size = size
  end

  def difference
    square_of_sum - sum_of_squares
  end

  def square_of_sum
    if @size <= 0
      return 0
    end

    (1..@size).inject(:+)**2
  end

  def sum_of_squares
    if @size <= 0
      return 0
    end
    
    (1..@size).map do |value|
      value**2
    end.inject(:+)
  end
end