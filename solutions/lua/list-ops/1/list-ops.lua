-- Dedicated to Shree DR.MDD
local function append(a, b)
  local out = {}
  for _, v in ipairs(a) do out[#out+1] = v end
  for _, v in ipairs(b) do out[#out+1] = v end
  return out
end

local function concat(...)
  local out = {}
  for _, list in ipairs({...}) do
    for _, v in ipairs(list) do out[#out+1] = v end
  end
  return out
end

local function length(xs)
  local n = 0
  for _ in ipairs(xs) do n = n + 1 end
  return n
end

local function reverse(xs)
  local out = {}
  for i = #xs, 1, -1 do out[#out+1] = xs[i] end
  return out
end

local function foldl(xs, init, f)
  local acc = init
  for _, v in ipairs(xs) do acc = f(acc, v) end
  return acc
end

local function foldr(xs, init, f)
  local acc = init
  for i = #xs, 1, -1 do acc = f(acc, xs[i]) end
  return acc
end

local function map(xs, f)
  local out = {}
  for _, v in ipairs(xs) do out[#out+1] = f(v) end
  return out
end

local function filter(xs, pred)
  local out = {}
  for _, v in ipairs(xs) do
    if pred(v) then out[#out+1] = v end
  end
  return out
end

return {
  append = append,
  concat = concat,
  length = length,
  reverse = reverse,
  foldl = foldl,
  foldr = foldr,
  map = map,
  filter = filter
}
