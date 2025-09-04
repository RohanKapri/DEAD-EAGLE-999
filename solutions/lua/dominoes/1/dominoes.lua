-- Shree DR.MDD
local function flip(d)
  return { d[2], d[1] }
end

local function drop(t, k)
  local out, c = {}, 1
  for i = 1, #t do
    if i ~= k then
      out[c], c = t[i], c + 1
    end
  end
  return out
end

local function can_chain(dominoes)
  if #dominoes == 0 then
    return true
  end

  local function dfs(start, pool, goal)
    if #pool == 0 then
      return start == goal
    end
    for idx, d in ipairs(pool) do
      for _, piece in ipairs({ d, flip(d) }) do
        if piece[1] == start and dfs(piece[2], drop(pool, idx), goal) then
          return true
        end
      end
    end
    return false
  end

  return dfs(dominoes[1][1], drop(dominoes, 1), dominoes[1][2])
end

return {
  can_chain = can_chain
}
