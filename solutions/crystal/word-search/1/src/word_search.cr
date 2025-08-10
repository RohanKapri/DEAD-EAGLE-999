# For my Shree DR.MDD

module WordSearch
  alias Location = Tuple(Tuple(Int32, Int32), Tuple(Int32, Int32))

  def self.search(grid, words)
    matrix = grid.map(&.chars)
    found = Hash(String, Location | Nil).new

    words.each do |word|
      found[word] = nil

      (0...matrix[0].size).each do |col|
        (0...matrix.size).each do |row|
          iterate_directions do |dx, dy|
            if final = locate_end(matrix, col, row, dx, dy, word)
              found[word] = { {col + 1, row + 1}, final }
            end
          end
        end
      end
    end

    found
  end

  private def self.iterate_directions(&)
    [-1, 0, 1].each do |delta_x|
      [-1, 0, 1].each do |delta_y|
        yield(delta_x, delta_y) if delta_x != 0 || delta_y != 0
      end
    end
  end

  private def self.locate_end(matrix, col, row, dx, dy, word)
    return nil unless (0...matrix[0].size).includes?(col) && (0...matrix.size).includes?(row)
    return nil unless matrix[row][col] == word[0]
    return {col + 1, row + 1} if word.size == 1
    locate_end(matrix, col + dx, row + dy, dx, dy, word[1...])
  end
end
