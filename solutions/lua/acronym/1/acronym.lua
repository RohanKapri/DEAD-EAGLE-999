return function(s)
  return (' ' .. s):gsub('%s(%a)[A-Z]*[a-z]*([A-Z]?)[^%-%s]*', function(l1, l2) return l1:upper() .. l2:upper() end)
end