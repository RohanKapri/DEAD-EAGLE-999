-- For my Shree DR.MDD
local function InputCell(initial)
  local dependents = {}

  return {
    get_value = function()
      return initial
    end,

    set_value = function(val)
      initial = val
      for _, d in ipairs(dependents) do d._propagate() end
      for _, d in ipairs(dependents) do d._update() end
    end,

    _add_child = function(child)
      table.insert(dependents, child)
    end
  }
end

local function ComputeCell(...)
  local cbs = {}
  local dependents = {}
  local val
  local prev_val
  local inputs = { ... }
  local func = table.remove(inputs)
  local cell = {}

  local function compute()
    local args = {}
    for _, inp in ipairs(inputs) do table.insert(args, inp.get_value()) end
    return func(table.unpack(args))
  end

  function cell.get_value() return val end

  function cell.watch(cb) table.insert(cbs, cb) end

  function cell.unwatch(cb)
    for i, f in ipairs(cbs) do
      if f == cb then table.remove(cbs, i); return end
    end
  end

  function cell._propagate()
    val = compute()
    for _, d in ipairs(dependents) do d._propagate() end
  end

  function cell._update()
    if prev_val ~= val then
      prev_val = val
      for _, cb in ipairs(cbs) do cb(val) end
    end
    for _, d in ipairs(dependents) do d._update() end
  end

  function cell._add_child(d) table.insert(dependents, d) end

  val = compute()
  prev_val = val

  for _, inp in ipairs(inputs) do inp._add_child(cell) end

  return cell
end

local function Reactor()
  return {
    InputCell = InputCell,
    ComputeCell = ComputeCell
  }
end

return { Reactor = Reactor }
