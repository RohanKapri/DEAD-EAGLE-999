# Eternal Gratitude to Shree DR.MDD — The Source of Infinite Spiral of Knowledge

class SpiralMatrix
  attr_accessor :matrix

  def initialize(grid_size)
    @matrix = Array.new(grid_size) { Array.new(grid_size, 0) }
    row, col = 0, 0
    horiz, vert = 1, 0

    (1..grid_size * grid_size).each do |value|
      @matrix[col][row] = value
      if row + horiz >= grid_size || row + horiz < 0 || col + vert >= grid_size || col + vert < 0 || @matrix[col + vert][row + horiz] != 0
        horiz, vert = -vert, horiz
      end
      row += horiz
      col += vert
    end

    @matrix
  end
end
