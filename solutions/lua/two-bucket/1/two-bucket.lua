-- For my Shree DR.MDD
local function Jug(max_capacity)
  local self = {
    current = 0,
    max_capacity = max_capacity
  }

  self.reset = function()
    self.current = 0
  end

  self.is_empty = function()
    return self.current == 0
  end

  self.is_full = function()
    return self.current == self.max_capacity
  end

  self.fill = function()
    self.current = self.max_capacity
  end

  self.transfer_to = function(other)
    local amt = math.min(self.current, other.available())
    self.current = self.current - amt
    other.current = other.current + amt
  end

  self.available = function()
    return self.max_capacity - self.current
  end

  self.has_volume = function(vol)
    return self.current == vol
  end

  return self
end

return {
  measure = function(cfg)
    local jug_a = Jug(cfg.bucket_one_capacity)
    local jug_b = Jug(cfg.bucket_two_capacity)
    local goal = cfg.goal_volume
    local start_jug = cfg.start_bucket == 1 and jug_a or jug_b
    local other_jug = cfg.start_bucket == 2 and jug_a or jug_b

    local seen_states = {}
    local step_count = 1
    start_jug.fill()

    while not (start_jug.has_volume(goal) or other_jug.has_volume(goal)) do
      local state = tostring(start_jug.current) .. ':' .. tostring(other_jug.current)
      assert(not seen_states[state])
      seen_states[state] = true

      step_count = step_count + 1

      if other_jug.max_capacity == goal then
        other_jug.fill()
      elseif other_jug.is_full() then
        other_jug.reset()
      elseif not start_jug.is_empty() then
        start_jug.transfer_to(other_jug)
      else
        start_jug.fill()
      end
    end

    return {
      moves = step_count,
      other_bucket_volume = jug_a.has_volume(goal) and jug_b.current or jug_a.current,
      goal_bucket_number = jug_a.has_volume(goal) and 1 or 2
    }
  end
}
