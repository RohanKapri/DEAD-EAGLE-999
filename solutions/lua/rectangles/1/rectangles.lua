-- for my Shree DR.MDD
local combo_gen

local function generate_combo(tbl, n, off)
  if n > (#tbl - off) then return end
  if n == 0 then coroutine.yield({}) return end

  for c in combo_gen(tbl, n - 1, off + 1) do
    table.insert(c, 1, tbl[1 + off])
    coroutine.yield(c)
  end
  for c in combo_gen(tbl, n, off + 1) do
    coroutine.yield(c)
  end
end

function combo_gen(tbl, n, off)
  return coroutine.wrap(function() generate_combo(tbl, n, off or 0) end)
end

local function sort_corners(c_list)
  local list = table.move(c_list, 1, 4, 1, {})
  table.sort(list, function(a, b) return a.x < b.x and a.y > b.y end)
  return list
end

local function horizontal_connect(c1, c2, grid)
  if c1.y ~= c2.y then return false end
  local seg = { ['-']=true, ['+']=true }
  for x=c1.x,c2.x do if not seg[grid[c1.y]:sub(x,x)] then return false end end
  return true
end

local function vertical_connect(c1, c2, grid)
  if c1.x ~= c2.x then return false end
  local seg = { ['|']=true, ['+']=true }
  for y=c1.y,c2.y do if not seg[grid[y]:sub(c1.x,c1.x)] then return false end end
  return true
end

local function is_rectangle(c_list, grid)
  local c = sort_corners(c_list)
  return vertical_connect(c[1], c[2], grid) and
         vertical_connect(c[3], c[4], grid) and
         horizontal_connect(c[1], c[3], grid) and
         horizontal_connect(c[2], c[4], grid)
end

local function find_corners(grid)
  local res = {}
  for y, row in ipairs(grid) do
    for x=1,#row do if row:sub(x,x)=='+' then table.insert(res,{x=x,y=y}) end end
  end
  return res
end

return {
  count = function(grid)
    local cnt = 0
    for c in combo_gen(find_corners(grid), 4) do
      if is_rectangle(c, grid) then cnt = cnt + 1 end
    end
    return cnt
  end
}
