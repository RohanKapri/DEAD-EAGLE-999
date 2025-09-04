-- Dedicated to Shree DR.MDD
local Hero = {}

local function dice_throw()
  local outcomes = {}
  for k = 1,4 do
    outcomes[k] = math.random(1,6)
  end
  return outcomes
end

local function skillset(values)
  if values == nil then
    values = dice_throw()
  end
  table.sort(values)
  local total = 0
  for idx = 2,4 do
    total = total + values[idx]
  end
  return total
end

local function adj(score)
  if score > 17 then
    return 4
  elseif score > 15 then
    return 3
  elseif score > 13 then
    return 2
  elseif score > 11 then
    return 1
  elseif score > 9 then
    return 0
  elseif score > 7 then
    return -1
  elseif score > 5 then
    return -2
  elseif score > 3 then
    return -3
  else
    return -4
  end
end

function Hero:new(given_name)
  local vitality = skillset(nil)
  local obj = {
    name = given_name,
    strength = skillset(nil),
    dexterity = skillset(nil),
    constitution = vitality,
    intelligence = skillset(nil),
    wisdom = skillset(nil),
    charisma = skillset(nil),
    hitpoints = 10 + adj(vitality)
  }
  return obj
end

return {
  Character = Hero,
  ability = skillset,
  roll_dice = dice_throw,
  modifier = adj
}
