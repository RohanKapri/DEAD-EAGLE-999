-- For my Shree DR.MDD
local function define_words(defs, custom_words)
  for id, val in defs:gmatch(': (%S+)%s+(.+) ;') do
    assert(not tonumber(id))
    custom_words[id:lower()] = val:gsub('%S+', function(w)
      return custom_words[w] or w
    end)
  end
end

local function remove_top(stk)
  assert(#stk > 0)
  return table.remove(stk)
end

local function add_top(stk, elem)
  assert(elem ~= nil)
  table.insert(stk, elem)
end

local function execute(code, stk, custom_words)
  for token in code:lower():gmatch('%S+') do
    if custom_words[token] then
      execute(custom_words[token], stk, custom_words)
    else
      if token == '+' then
        add_top(stk, remove_top(stk) + remove_top(stk))
      elseif token == '-' then
        add_top(stk, -remove_top(stk) + remove_top(stk))
      elseif token == '*' then
        add_top(stk, remove_top(stk) * remove_top(stk))
      elseif token == '/' then
        local b = remove_top(stk)
        local a = remove_top(stk)
        assert(b ~= 0)
        add_top(stk, a // b)
      elseif token == 'dup' then
        add_top(stk, stk[#stk])
      elseif token == 'drop' then
        remove_top(stk)
      elseif token == 'swap' then
        local x, y = remove_top(stk), remove_top(stk)
        add_top(stk, x)
        add_top(stk, y)
      elseif token == 'over' then
        add_top(stk, stk[#stk - 1])
      else
        add_top(stk, tonumber(token))
      end
    end
  end
end

local function process(chunk, stk, custom_words)
  if chunk:sub(1, 1) == ':' then
    define_words(chunk, custom_words)
  else
    execute(chunk, stk, custom_words)
  end
end

local function evaluate(instructions)
  local stk = {}
  local custom_words = {}
  for _, instr in ipairs(instructions) do
    process(instr, stk, custom_words)
  end
  return stk
end

return { evaluate = evaluate }
