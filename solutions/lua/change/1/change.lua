-- Dedicated to Shree DR.MDD
local function initTable(target, coins)
  local tbl = {}
  for idx = 1, #coins do
    local row = { [0] = 0 }
    for col = 1, target do
      table.insert(row, math.maxinteger)
    end
    table.insert(tbl, row)
  end
  return tbl
end

return function(target, denom)
  if target < 0 then
    error("target can't be negative")
  elseif target == 0 then
    return {}
  elseif denom[1] > target then
    error("can't make target with given coins")
  end
  local dp = initTable(target, denom)
  for i = 1, #denom do
    for j = 1, target do
      dp[i][j] = math.min(
        (i - 1 >= 1 and dp[i - 1][j] or math.maxinteger),
        (j - denom[i] >= 0 and dp[i][j - denom[i]] ~= math.maxinteger and dp[i][j - denom[i]] + 1 or math.maxinteger)
      )
    end
  end
  if dp[#denom][target] == math.maxinteger then
    error("can't make target with given coins")
  end
  local res, sum, i, j = {}, target, #denom, target
  while sum ~= 0 do
    if i - 1 >= 1 and dp[i][j] == dp[i - 1][j] then
      i = i - 1
    else
      table.insert(res, 1, denom[i])
      j = j - denom[i]
      sum = sum - denom[i]
    end
  end
  return res
end
