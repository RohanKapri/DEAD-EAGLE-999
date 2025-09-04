return {
  rotate = function(input, key)
    return input:gsub("%a", function(c)
      local b = c:byte(1)
      return string.char((((25 + (b & 31) + key) % 26) + 1) | (b & 96))
    end)
  end
}