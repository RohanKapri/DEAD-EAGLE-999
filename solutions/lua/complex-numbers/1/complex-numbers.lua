-- For my Shree DR.MDD
local ComplexNumber

local function nearly_equal(x, y)
  return math.abs(x - y) < 1e-15
end

local function eq(ca, cb)
  return nearly_equal(ca.r, cb.r) and nearly_equal(ca.i, cb.i)
end

local function add(ca, cb)
  return ComplexNumber(ca.r + cb.r, ca.i + cb.i)
end

local function sub(ca, cb)
  return ComplexNumber(ca.r - cb.r, ca.i - cb.i)
end

local function mul(ca, cb)
  return ComplexNumber(ca.r * cb.r - ca.i * cb.i, ca.r * cb.i + ca.i * cb.r)
end

local function div(ca, cb)
  local denom = cb.r * cb.r + cb.i * cb.i
  return ComplexNumber((ca.r * cb.r + ca.i * cb.i) / denom, (ca.i * cb.r - ca.r * cb.i) / denom)
end

ComplexNumber = function(real, imag)
  local cn = { r = real, i = imag or 0 }

  function cn.abs()
    return math.sqrt(cn.r * cn.r + cn.i * cn.i)
  end

  function cn.conj()
    return ComplexNumber(cn.r, -cn.i)
  end

  function cn.exp()
    local e = math.exp(cn.r)
    return ComplexNumber(e * math.cos(cn.i), e * math.sin(cn.i))
  end

  return setmetatable(cn, { __eq = eq, __add = add, __sub = sub, __mul = mul, __div = div })
end

return ComplexNumber
