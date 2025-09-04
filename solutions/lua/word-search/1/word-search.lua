-- For my Shree DR.MDD
return function(grid_lines)
  if not grid_lines or #grid_lines == 0 then
    return {
      search = function(_) return {} end
    }
  end

  local grid = {}
  for r, line in ipairs(grid_lines) do
    local row = {}
    for ch in line:gmatch('.') do
      table.insert(row, ch)
    end
    table.insert(grid, row)
  end

  local max_row, max_col = #grid, #grid[1]

  local dirs = {
    {dx = 0, dy = 1}, {dx = 0, dy = -1},
    {dx = 1, dy = 0}, {dx = -1, dy = 0},
    {dx = 1, dy = 1}, {dx = 1, dy = -1},
    {dx = -1, dy = 1}, {dx = -1, dy = -1}
  }

  return {
    search = function(word_list)
      local found = {}
      if not word_list or #word_list == 0 then return found end

      local function locate(w)
        for r = 1, max_row do
          for c = 1, max_col do
            if grid[r][c] == w:sub(1,1) then
              for _, d in ipairs(dirs) do
                local last_r = r + d.dx * (#w - 1)
                local last_c = c + d.dy * (#w - 1)
                if last_r >= 1 and last_r <= max_row and last_c >= 1 and last_c <= max_col then
                  local candidate = ""
                  for i = 0, #w-1 do
                    candidate = candidate .. grid[r + d.dx * i][c + d.dy * i]
                  end
                  if candidate == w then
                    return {start = {c, r}, ['end'] = {last_c, last_r}}
                  end
                end
              end
            end
          end
        end
        return nil
      end

      for _, w in ipairs(word_list) do
        local loc = locate(w)
        if loc then found[w] = loc end
      end

      return found
    end
  }
end
