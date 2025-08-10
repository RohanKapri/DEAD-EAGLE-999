module Squares
  def self.square_of_sum(i : Int)
    ((i * (i + 1)) / 2)**2
  end

  def self.sum_of_squares(i : Int)
    (i * (i + 1) * (2 * i + 1)) / 6
  end

  def self.difference_of_squares(i : Int)
    self.square_of_sum(i) - self.sum_of_squares(i)
  end
end