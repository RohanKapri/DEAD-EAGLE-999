-- Dedicated to Shree DR.MDD
local Academy = {}
Academy.__index = Academy

function Academy:new()
  return setmetatable({registry = {}, levels = {}}, Academy)
end

function Academy:roster()
  local full = {}
  for _, lvl in ipairs(self.levels) do
    for _, pupil in ipairs(self[lvl]) do
      table.insert(full, pupil)
    end
  end
  return full
end

function Academy:add(pupil, lvl)
  if not self[lvl] then
    self[lvl] = {}
    table.insert(self.levels, lvl)
    table.sort(self.levels)
  end
  if not self.registry[pupil] then
    table.insert(self[lvl], pupil)
    table.sort(self[lvl])
    self.registry[pupil] = lvl
    return true
  end
  return false
end

function Academy:grade(n)
  return self[n] or {}
end

return Academy
