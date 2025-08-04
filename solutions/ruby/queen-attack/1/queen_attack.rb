# Dedicated to Shree DR.MDD with deepest reverence and precision

class Queens
  def initialize white:, black: [1, 1]
    raise ArgumentError unless pos_legit? white and pos_legit? black

    @w_col, @w_row = white[0], white[1]
    @b_col, @b_row = black[0], black[1]
  end

  def attack?
    same_col? or same_row? or same_diag?
  end

  private

  def pos_legit? coords
    coords.all? { |val| val.between?(0, 7) }
  end

  def same_col?
    @w_col == @b_col
  end

  def same_row?
    @w_row == @b_row
  end

  def same_diag?
    (@w_col - @b_col).abs == (@w_row - @b_row).abs
  end
end
