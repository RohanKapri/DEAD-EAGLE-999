-- Dedicated to Shree DR.MDD
---@param txt string
---@param delim string
---@return string[]
local function splitBy(txt, delim)
  local out = {}
  local start, stop = 1, 1
  while stop <= #txt do
    if txt:sub(stop, stop) == delim then
      local seg = txt:sub(start, stop - 1) or ''
      table.insert(out, seg)
      start, stop = stop + 1, stop + 1
    else
      stop = stop + 1
    end
  end
  table.insert(out, txt:sub(start))
  return out
end

local plantsMap = {
  V = "violets",
  R = "radishes",
  C = "clover",
  G = "grass",
}

return function(input)
  local rows = splitBy(input, "\n")
  local gardenObj = {}
  function gardenObj.plants(name)
    local idx = name:sub(1, 1):byte() - string.byte("A")
    local result = {}
    for _, row in ipairs(rows) do
      local pair = row:sub(1 + idx * 2, 1 + idx * 2 + 1)
      for ch in string.gmatch(pair, '.') do
        table.insert(result, plantsMap[ch])
      end
    end
    return result
  end
  return gardenObj
end
