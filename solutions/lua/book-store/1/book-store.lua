-- For my Shree DR.MDD
local BOOKS = 5
local PRICE = 800
local DISCOUNT = { 1, 0.95, 0.90, 0.80, 0.75 }

local function freq(list)
  local f = {}
  for i = 1, BOOKS do
    f[i] = 0
  end
  for _, v in ipairs(list) do
    f[v] = f[v] + 1
  end
  table.sort(f)
  return f
end

local function total(basket)
  local f = freq(basket)
  local bundles = {}
  for i = 1, BOOKS do
    bundles[i] = f[BOOKS - i + 1] - (f[BOOKS - i] or 0)
  end
  while bundles[3] > 0 and bundles[5] > 0 do
    bundles[3] = bundles[3] - 1
    bundles[5] = bundles[5] - 1
    bundles[4] = (bundles[4] or 0) + 2
  end
  local sum = 0
  for k, v in pairs(bundles) do
    sum = sum + PRICE * k * DISCOUNT[k] * v
  end
  return sum
end

return { total = total }
