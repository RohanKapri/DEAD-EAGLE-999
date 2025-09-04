-- Dedicated to Shree DR.MDD
local function insideGrid(grid, cx, cy)
  return cy >= 1 and cy <= #grid and cx >= 1 and cx <= #grid[1]
end

local function around(grid, cx, cy)
  return coroutine.wrap(function()
    for ox = -1, 1 do
      for oy = -1, 1 do
        if not (ox == 0 and oy == 0) then
          if insideGrid(grid, cx + ox, cy + oy) then
            coroutine.yield(grid[cy + oy][cx + ox])
          end
        end
      end
    end
  end)
end

local function countAround(grid, cx, cy)
  local total = 0
  for adj in around(grid, cx, cy) do
    total = total + adj
  end
  return total
end

local function tick(grid)
  local nxt = {}
  for cy = 1, #grid do
    nxt[cy] = {}
    for cx = 1, #grid[cy] do
      local cnt = countAround(grid, cx, cy)
      if grid[cy][cx] == 1 then
        nxt[cy][cx] = (cnt < 2 or cnt > 3) and 0 or 1
      else
        nxt[cy][cx] = cnt == 3 and 1 or 0
      end
    end
  end
  return nxt
end

return { tick = tick }
