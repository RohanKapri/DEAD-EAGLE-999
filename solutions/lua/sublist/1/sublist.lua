local function find(l1, l2)
  if #l1 == 0 then return true end
  for i = 1, #l2 - #l1 + 1 do
    if l2[i] == l1[1] then
      local found = true
      for j = 2, #l1 do
        if l1[j] ~= l2[i+j-1] then
          found = false
          break
        end
      end
      if found then return true end
    end
  end
  return false
end
return function(l1, l2)
  if find(l1, l2) then
    return #l1 == #l2 and "equal" or "sublist"
  end
  return find(l2, l1) and "superlist" or "unequal"
end