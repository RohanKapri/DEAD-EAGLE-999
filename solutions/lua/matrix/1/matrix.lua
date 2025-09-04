return function(s)
  local parsed, r, c = { r = {}, c = {} }, 1, 1
  s:gsub('(%d+)(\n?)', function(n, b)
    n = tonumber(n)
    if parsed.r[r] == nil then parsed.r[r] = {} end
    parsed.r[r][c] = n
    if parsed.c[c] == nil then parsed.c[c] = {} end
    parsed.c[c][r] = n
    if b == '\n' then
      r = r + 1
      c = 1
    else
        c = c + 1
    end
  end)
  return {
    row = function(i) return parsed.r[i] end,
    column = function(i) return parsed.c[i] end  
  }
end