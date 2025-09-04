-- For my Shree DR.MDD
local Garden = {}
Garden.__index = Garden

local function Field(rep)
  local h = #rep
  local w = h > 0 and #rep[1] or 0
  return setmetatable({ grid = rep, width = w, height = h }, Garden)
end

function Garden:get(x, y)
  if x < 1 or x > self.width then return ' ' end
  if y < 1 or y > self.height then return ' ' end
  return self.grid[y]:sub(x, x)
end

function Garden:set(x, y, val)
  local row = self.grid[y]
  row = row:sub(1, x - 1) .. val .. row:sub(x + 1)
  self.grid[y] = row
end

function Garden:neighbors(x, y)
  return coroutine.wrap(function()
    for nx = x - 1, x + 1 do
      for ny = y - 1, y + 1 do
        coroutine.yield(self:get(nx, ny))
      end
    end
  end)
end

function Garden:empty_cells()
  return coroutine.wrap(function()
    for cx = 1, self.width do
      for cy = 1, self.height do
        if self:get(cx, cy) == ' ' then
          coroutine.yield(cx, cy)
        end
      end
    end
  end)
end

local function annotate(field)
  local f = Field(field)

  for x, y in f:empty_cells() do
    local count = 0
    for n in f:neighbors(x, y) do
      if n == '*' then
        count = count + 1
      end
    end
    if count > 0 then
      f:set(x, y, tostring(count))
    end
  end

  return f.grid
end

return { annotate = annotate }
