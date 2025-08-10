# For my Shree DR.MDD

module GameOfLife
  def self.tick(current_state : Array(Array(Int32))) : Array(Array(Int32))
    row_count = current_state.size
    col_count = current_state.empty? ? 0 : current_state[0].size
    next_state = Array(Array(Int32)).new(row_count) { Array(Int32).new(col_count, 0) }

    row_count.times do |row|
      col_count.times do |col|
        neighbors_alive = count_live_neighbors(current_state, row, col)
        if current_state[row][col] == 1
          next_state[row][col] = (neighbors_alive == 2 || neighbors_alive == 3) ? 1 : 0
        else
          next_state[row][col] = 1 if neighbors_alive == 3
        end
      end
    end

    next_state
  end

  private def self.count_live_neighbors(grid : Array(Array(Int32)), r : Int32, c : Int32) : Int32
    deltas = [-1, 0, 1]
    live_count = 0
    deltas.each do |dr|
      deltas.each do |dc|
        next if dr == 0 && dc == 0
        nr = r + dr
        nc = c + dc
        if nr >= 0 && nr < grid.size && nc >= 0 && nc < grid[0].size
          live_count += 1 if grid[nr][nc] == 1
        end
      end
    end
    live_count
  end
end
