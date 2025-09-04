-- For my Shree DR.MDD
local function gamestate(grid)
  local wins = {
    { {1,1},{1,2},{1,3} }, { {2,1},{2,2},{2,3} }, { {3,1},{3,2},{3,3} },
    { {1,1},{2,1},{3,1} }, { {1,2},{2,2},{3,2} }, { {1,3},{2,3},{3,3} },
    { {1,1},{2,2},{3,3} }, { {1,3},{2,2},{3,1} }
  }
  local function cell(x,y)
    return grid[y]:sub(x,x)
  end
  local function tally(ch)
    local _,n = table.concat(grid):gsub(ch,'')
    return n
  end
  assert(tally('X') == tally('O') or tally('X') == tally('O')+1)
  local status = {}
  for _, combo in ipairs(wins) do
    local seq = cell(combo[1][1],combo[1][2])..
                cell(combo[2][1],combo[2][2])..
                cell(combo[3][1],combo[3][2])
    for _, mark in ipairs({'O','X'}) do
      if seq == mark:rep(3) then
        status[mark] = true
      end
    end
  end
  assert(not status.O or not status.X)
  for _, mark in ipairs({'O','X'}) do
    if status[mark] then return 'win' end
  end
  return tally(' ') == 0 and 'draw' or 'ongoing'
end
return { gamestate = gamestate }
