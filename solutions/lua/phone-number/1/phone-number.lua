local function clean(number)
  return assert(number:gsub("[%D]", ""):match("^1?([2-9]%d%d[2-9]%d%d%d%d%d%d)$"), "Invalid number")
end

return {clean = clean}