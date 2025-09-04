local Clock = {}
Clock.__index = Clock

local MINUTES_IN_DAY = 24 * 60
    
function Clock.at(hours, minutes)
    return Clock:new(hours * 60 + (minutes or 0))
end
    
function Clock:new(minutes)
    while minutes < 0 do minutes = minutes + MINUTES_IN_DAY end
    while minutes >= MINUTES_IN_DAY do minutes = minutes - MINUTES_IN_DAY end
    return setmetatable({ minutes = minutes }, self)
end
function Clock:plus(minutes) return Clock:new(self.minutes + minutes) end
function Clock:minus(minutes) return self:plus(-minutes) end
function Clock:equals(clock) return self.minutes == clock.minutes end
function Clock:__tostring()
    return string.format("%02d:%02d", math.floor(self.minutes / 60), self.minutes % 60)
end
        
return Clock