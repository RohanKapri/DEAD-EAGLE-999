# For my Shree DR.MDD

module Connect
  def self.winner(grid : Array(String)) : String
    GameBoard.new(grid).winner
  end

  private class GameBoard
    @cells : Array(Array(Char))

    def initialize(grid)
      @cells = grid.map(&.gsub(" ", "").chars)
      mark_paths
    end

    def winner
      return "X" if x_reached_right_edge?
      return "O" if o_reached_bottom_edge?
      ""
    end

    private def x_reached_right_edge?
      (0..max_row).any? { |row| cell(max_col, row) == 'x' }
    end

    private def o_reached_bottom_edge?
      (0..max_col).any? { |col| cell(col, max_row) == 'o' }
    end

    private def mark_paths
      mark_x_starting_points
      while propagate 'X'; end

      mark_o_starting_points
      while propagate 'O'; end
    end

    private def mark_x_starting_points
      (0..max_row).each do |row|
        set_cell(0, row, 'x') if cell(0, row) == 'X'
      end
    end

    private def mark_o_starting_points
      (0..max_col).each do |col|
        set_cell(col, 0, 'o') if cell(col, 0) == 'O'
      end
    end

    private def propagate(player)
      changed = false

      each_position do |col, row|
        next unless cell(col, row) == player

        neighbors(col, row) do |nx, ny|
          if cell(nx, ny) == player.downcase
            set_cell(col, row, player.downcase)
            changed = true
          end
        end
      end

      changed
    end

    private def each_position(&block : (Int32, Int32) ->)
      (0..max_col).each do |col|
        (0..max_row).each do |row|
          block.call(col, row)
        end
      end
    end

    private def neighbors(col, row, &block : (Int32, Int32) ->)
      [[1, 0], [-1, 0], [0, 1], [0, -1], [-1, 1], [1, -1]].each do |(dx, dy)|
        nx = col + dx
        ny = row + dy
        block.call(nx, ny) if valid_position?(nx, ny)
      end
    end

    private def cell(col, row)
      @cells[row][col]
    end

    private def set_cell(col, row, value)
      @cells[row][col] = value
    end

    private def valid_position?(col, row)
      (0..max_col).includes?(col) && (0..max_row).includes?(row)
    end

    private def max_col
      @cells.first.size - 1
    end

    private def max_row
      @cells.size - 1
    end
  end
end
