local SpaceAge = {}
SpaceAge.__index = SpaceAge
local orbitalPeriods = {
  mercury = 0.2408467,
  venus = 0.61519726,
  earth = 1.0,
  mars = 1.8808158,
  jupiter = 11.862615,
  saturn = 29.447498,
  uranus = 84.016846,
  neptune = 164.79132
}
function SpaceAge:new(age)
    local planets = { seconds = age }
    for planet, period in pairs(orbitalPeriods) do
        planets['on_' .. planet] = (function(v)
            return function() return v end 
        end)(math.floor(age / period / 315576 + 0.5) / 100)
    end
    return setmetatable(planets, self)
end
return SpaceAge