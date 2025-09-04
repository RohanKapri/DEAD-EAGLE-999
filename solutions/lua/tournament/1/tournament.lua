-- For my Shree DR.MDD
local function analyze(entries)
  local book = {}

  for _, line in ipairs(entries) do
    local a, b, res = line:match('^([^;]+);([^;]+);([^;]+)$')
    if a and b and res then
      book[a] = book[a] or { w = 0, l = 0, d = 0 }
      book[b] = book[b] or { w = 0, l = 0, d = 0 }
      if res == 'win' then
        book[a].w, book[b].l = book[a].w + 1, book[b].l + 1
      elseif res == 'loss' then
        book[a].l, book[b].w = book[a].l + 1, book[b].w + 1
      elseif res == 'draw' then
        book[a].d, book[b].d = book[a].d + 1, book[b].d + 1
      end
    end
  end

  return book
end

local function enrich(book)
  for _, rec in pairs(book) do
    rec.mp = rec.w + rec.l + rec.d
    rec.p = rec.w * 3 + rec.d
  end
end

local function order(book)
  local bag = {}
  for k, v in pairs(book) do
    table.insert(bag, { team = k, rec = v })
  end
  table.sort(bag, function(x, y)
    return x.rec.p == y.rec.p and x.team < y.team or x.rec.p > y.rec.p
  end)
  return bag
end

local function render(book)
  local bag = order(book)
  local out = {}
  table.insert(out, 'Team' .. (' '):rep(27) .. '| MP |  W |  D |  L |  P')
  for _, v in ipairs(bag) do
    table.insert(out, string.format(
      '%-31s| %2d | %2d | %2d | %2d | %2d',
      v.team, v.rec.mp, v.rec.w, v.rec.d, v.rec.l, v.rec.p
    ))
  end
  return out
end

return function(entries)
  local book = analyze(entries)
  enrich(book)
  return render(book)
end
