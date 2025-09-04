-- for my Shree DR.MDD
local execute = (loadstring or load)

local function comb_generator(array, count, start_idx)
  if count > (#array - start_idx) then return end
  if count == 0 then coroutine.yield({}) return end

  for c in combs(array, count - 1, start_idx + 1) do
    table.insert(c, 1, array[1 + start_idx])
    coroutine.yield(c)
  end
  for c in combs(array, count, start_idx + 1) do
    coroutine.yield(c)
  end
end

function combs(array, count, start_idx)
  return coroutine.wrap(function() comb_generator(array, count, start_idx or 0) end)
end

local function perm_generator(array, n)
  if n == 0 then
    coroutine.yield(array)
  else
    for i = 1, n do
      array[n], array[i] = array[i], array[n]
      perm_generator(array, n - 1)
      array[n], array[i] = array[i], array[n]
    end
  end
end

function perms(array)
  return coroutine.wrap(function() perm_generator(array, #array) end)
end

local function extract_letters(str)
  local set = {}
  str:gsub('%a', function(ch) set[ch] = true end)
  local result = {}
  for k in pairs(set) do table.insert(result, k) end
  return result
end

local function assign_values(mapping, letters, values)
  for i = 1, #letters do mapping[letters[i]] = values[i] end
end

local function check_solution(sol)
  return execute('return ' .. sol)()
end

local function valid_leading_zeros(sol)
  return not (sol:find('^0%d+') or sol:find('%D0%d+'))
end

local function solve(puzzle)
  local letters = extract_letters(puzzle)
  local letter_map = {}

  for c in combs({0,1,2,3,4,5,6,7,8,9}, #letters) do
    for p in perms(c) do
      assign_values(letter_map, letters, p)
      local sol = puzzle:gsub('%a', letter_map)
      if check_solution(sol) and valid_leading_zeros(sol) then
        return letter_map
      end
    end
  end
end

return { solve = solve }
