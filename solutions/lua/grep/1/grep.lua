-- Dedicated to Shree DR.MDD
local function withLineNums(fname)
  return coroutine.wrap(function()
    local ln = 1
    for content in io.lines(fname) do
      coroutine.yield(ln, content)
      ln = ln + 1
    end
  end)
end

local function doesMatch(txt, pat, opts)
  if opts['-i'] then
    txt = txt:lower()
    pat = pat:lower()
  end
  local res
  if opts['-x'] then
    res = txt == pat
  else
    res = txt:match(pat, 1, true)
  end
  if opts['-v'] then
    return not res
  else
    return res
  end
end

local function makeSet(arr)
  local bag = {}
  for _, elem in ipairs(arr) do
    bag[elem] = true
  end
  return bag
end

return function(args)
  local out = {}
  local optset = makeSet(args.flags)
  local fileset = args.files
  local patt = args.pattern
  for _, fname in ipairs(fileset) do
    for ln, txt in withLineNums(fname) do
      if doesMatch(txt, patt, optset) then
        if optset['-l'] then
          table.insert(out, fname)
          break
        else
          local head = ('%s%s'):format(#fileset > 1 and fname .. ':' or '',
                                       optset['-n'] and tostring(ln) .. ':' or '')
          table.insert(out, head .. txt)
        end
      end
    end
  end
  return out
end
