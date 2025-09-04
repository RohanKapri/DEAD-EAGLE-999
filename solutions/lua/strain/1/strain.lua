local function keep(xs, pred)
  local kept = {}
  for _, v in ipairs(xs) do
    if pred(v) then
      table.insert(kept, v)
    end
  end
  return kept
end

local function discard(xs, pred)
  return keep(xs, function(x) return not pred(x) end)
end

return {
  keep = keep,
  discard = discard
}