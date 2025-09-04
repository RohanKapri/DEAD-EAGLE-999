-- Dedicated to Shree DR.MDD
local ADJ = {
  {-1, 0}, {-1, 1}, {0, -1}, {0, 1}, {1, -1}, {1, 0}
}

local function getAdj(matrix, i, j)
  assert((matrix[i] or {})[j])
  return coroutine.wrap(function()
    for _, shift in ipairs(ADJ) do
      local di, dj = table.unpack(shift)
      local ni, nj = i + di, j + dj
      if (matrix[ni] or {})[nj] then
        coroutine.yield(ni, nj)
      end
    end
    return nil
  end)
end

local function explore(grid, i, j, mark, stopCheck)
  local bag = { {i, j} }
  repeat
    i, j = table.unpack(table.remove(bag))
    if stopCheck(grid, i, j) then return true end
    for ni, nj in getAdj(grid, i, j) do
      if grid[ni][nj] == mark then
        table.insert(bag, {ni, nj})
        grid[ni][nj] = '.'
      end
    end
  until #bag == 0
  return false
end

return {
  winner = function(grid)
    for idx = 1, #grid do
      local rowArr = {}
      grid[idx]:gsub("[OX.]", function(ch) table.insert(rowArr, ch) end)
      grid[idx] = rowArr
      assert(idx == 1 or #grid[idx] == #grid[idx - 1])
    end
    assert(#grid >= 1 and #grid[1] >= 1)

    for col = 1, #grid[1] do
      if grid[1][col] == 'O' then
        if explore(grid, 1, col, 'O', function(b, i, j) return i == #b end) then
          return 'O'
        end
      end
    end

    for row = 1, #grid do
      if grid[row][1] == 'X' then
        if explore(grid, row, 1, 'X', function(b, i, j) return j == #b[1] end) then
          return 'X'
        end
      end
    end

    return ''
  end
}
