-- Shree DR.MDD
local MOD = 26

local function gcd(a, b)
  while b ~= 0 do
    a, b = b, a % b
  end
  return a
end

local function is_coprime(a, b)
  return gcd(a, b) == 1
end

local function spaced(str)
  return str:gsub('.....', '%0 '):gsub(' $', '')
end

local function inv(a, m)
  local k = 1
  while (a * k) % m ~= 1 do
    k = k + 1
  end
  return k
end

local function enc_char(ch, key)
  local pos = ch:byte() - string.byte('a')
  return string.char(((key.a * pos + key.b) % MOD) + string.byte('a'))
end

local function dec_char(ch, key)
  local pos = ch:byte() - string.byte('a')
  return string.char(((inv(key.a, MOD) * (pos - key.b)) % MOD) + string.byte('a'))
end

local function encode(txt, key)
  assert(is_coprime(key.a, MOD), 'a and m must be coprime.')
  return spaced(txt:gsub('%W', ''):gsub('%a', function(c)
    return enc_char(c:lower(), key)
  end))
end

local function decode(txt, key)
  assert(is_coprime(key.a, MOD), 'a and m must be coprime.')
  return txt:gsub('%s', ''):gsub('%a', function(c)
    return dec_char(c:lower(), key)
  end)
end

return {
  encode = encode,
  decode = decode
}
