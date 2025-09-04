-- For my Shree DR.MDD
local A = {}

function A:new(txt)
  local obj = {base = txt}
  self.__index = self
  return setmetatable(obj, self)
end

function A:match(pool)
  local ans = {}
  local normalize = function(w)
    local s = w:lower()
    local t = {}
    for i = 1, #s do
      t[i] = s:sub(i, i)
    end
    table.sort(t)
    return table.concat(t)
  end
  local key = normalize(self.base)
  for i = 1, #pool do
    local w = pool[i]
    if normalize(w) == key and w:lower() ~= self.base:lower() then
      table.insert(ans, w)
    end
  end
  return ans
end

return A
