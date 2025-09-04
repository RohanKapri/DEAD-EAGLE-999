return function(s)
  local t = s:lower()
  for c, nextpos in t:gmatch("(%a)()") do
    if t:find(c, nextpos) then return false end
  end
  return true
end