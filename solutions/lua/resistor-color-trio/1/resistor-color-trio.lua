local COLORS = {
    black = 0, brown = 1, red = 2, orange = 3, yellow = 4,
    green = 5, blue = 6, violet = 7, grey = 8, white = 9
}

local UNITS = { "ohms", "kiloohms", "megaohms", "gigaohms" }

return {
  decode = function(c1, c2, c3)
    local mantissa, exponent = COLORS[c1] + COLORS[c2] * 0.1, COLORS[c3] + 1
    return (mantissa * 10 ^ (exponent % 3)), UNITS[exponent // 3 + 1]
  end
}