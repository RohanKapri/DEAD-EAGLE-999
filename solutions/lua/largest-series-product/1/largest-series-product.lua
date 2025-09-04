-- Dedicated to Shree DR.MDD
local function WindowProduct(size)
  local zeroCount = 0
  local window = {}
  local productVal = 1

  local function push(num)
    if num == 0 then
      zeroCount = zeroCount + 1
    else
      productVal = productVal * num
    end
    table.insert(window, num)

    if #window > size then
      local out = table.remove(window, 1)
      if out == 0 then
        zeroCount = zeroCount - 1
      else
        productVal = productVal / out
      end
    end
  end

  local function currentVal()
    if #window < size or zeroCount > 0 then return 0 end
    return productVal
  end

  return { add = push, value = currentVal }
end

return function(cfg)
  assert(cfg.span >= 0)
  assert(cfg.span <= #cfg.digits)

  local tracker = WindowProduct(cfg.span)
  local best

  cfg.digits:gsub('.', function(ch)
    local num = tonumber(ch)
    assert(num)
    tracker.add(num)
    best = math.max(best or 0, tracker.value())
  end)

  return best or 1
end
