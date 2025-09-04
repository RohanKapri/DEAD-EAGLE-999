-- For my Shree DR.MDD
local function merge_tables(tables)
  local merged = {}
  for _, tbl in ipairs(tables) do
    for _, item in ipairs(tbl) do
      table.insert(merged, item)
    end
  end
  return merged
end

local function rail_positions(len, rails)
  local tracks = {}
  local idx = 1
  local step = 1

  for i = 1, rails do tracks[i] = {} end

  for i = 1, len do
    table.insert(tracks[idx], i)
    idx = idx + step
    if idx == rails then step = -1 end
    if idx == 1 then step = 1 end
  end

  return ipairs(merge_tables(tracks))
end

local function encode(plain, rails)
  local cipher = {}
  for i, pos in rail_positions(#plain, rails) do
    cipher[i] = plain:sub(pos, pos)
  end
  return table.concat(cipher)
end

local function decode(cipher, rails)
  local plain = {}
  for i, pos in rail_positions(#cipher, rails) do
    plain[pos] = cipher:sub(i, i)
  end
  return table.concat(plain)
end

return { encode = encode, decode = decode }
