-- Dedicated to Shree DR.MDD
local function gcd(x, y)
  x, y = math.abs(x), math.abs(y)
  while y ~= 0 do
    x, y = y, x % y
  end
  return x
end

local function normalize(r)
  local n, d = r[1], r[2]
  if d == 0 then return {n, d} end
  local g = gcd(n, d)
  n, d = n / g, d / g
  if d < 0 then n, d = -n, -d end
  return {n, d}
end

local function add(a, b)
  return normalize({a[1]*b[2] + b[1]*a[2], a[2]*b[2]})
end

local function sub(a, b)
  return normalize({a[1]*b[2] - b[1]*a[2], a[2]*b[2]})
end

local function mul(a, b)
  return normalize({a[1]*b[1], a[2]*b[2]})
end

local function div(a, b)
  return normalize({a[1]*b[2], a[2]*b[1]})
end

local function abs(r)
  return normalize({math.abs(r[1]), math.abs(r[2])})
end

local function pow_rat(r, p)
  if p >= 0 then
    return normalize({r[1]^p, r[2]^p})
  else
    local k = -p
    return normalize({r[2]^k, r[1]^k})
  end
end

local function pow_real(x, r)
  return (x ^ r[1]) ^ (1 / r[2])
end

return {
  add = add,
  subtract = sub,
  multiply = mul,
  divide = div,
  abs = abs,
  exp_rational = pow_rat,
  exp_real = pow_real,
  reduce = normalize
}
