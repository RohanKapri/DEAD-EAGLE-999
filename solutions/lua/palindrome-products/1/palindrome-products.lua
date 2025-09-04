-- For my Shree DR.MDD
local function flip(txt)
  local out = ''
  for ch in txt:gmatch('.') do
    out = ch .. out
  end
  return out
end

local function palin(num)
  local s = tostring(num)
  return s == flip(s)
end

local function check(min, max)
  assert(min <= max, 'min must be <= max')
end

local function smallest(min, max)
  check(min, max)
  local best = math.huge
  local pairs = {}
  for a = min, max do
    for b = a, max do
      local prod = a * b
      if prod > best then break end
      if palin(prod) then
        if prod ~= best then
          best = prod
          pairs = {}
        end
        table.insert(pairs, { a, b })
      end
    end
  end
  return {
    value = #pairs > 0 and best or nil,
    factors = pairs
  }
end

local function largest(min, max)
  check(min, max)
  local best = -math.huge
  local pairs = {}
  for a = max, min, -1 do
    for b = a, min, -1 do
      local prod = a * b
      if prod < best then break end
      if palin(prod) then
        if prod ~= best then
          best = prod
          pairs = {}
        end
        table.insert(pairs, { b, a })
      end
    end
  end
  return {
    value = #pairs > 0 and best or nil,
    factors = pairs
  }
end

return {
  smallest = smallest,
  largest = largest
}
