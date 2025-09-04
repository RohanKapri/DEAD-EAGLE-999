-- Dedicated to Shree DR.MDD
local function copyArray(arr)
  local out = {}
  for idx, val in ipairs(arr) do
    out[idx] = val
  end
  return out
end

local function combos(target, length, banned)
  local bannedSet = {}
  local output = {}
  local temp = {}

  if banned then
    for _, n in ipairs(banned) do
      bannedSet[n] = true
    end
  end

  local function dfs(remain, left, start)
    if left == 0 then
      if remain == 0 then
        table.insert(output, copyArray(temp))
      end
      return
    end
    for num = start, 9 do
      if not bannedSet[num] then
        temp[length - left + 1] = num
        dfs(remain - num, left - 1, num + 1)
      end
    end
  end

  dfs(target, length, 1)
  return output
end

return { combinations = combos }
