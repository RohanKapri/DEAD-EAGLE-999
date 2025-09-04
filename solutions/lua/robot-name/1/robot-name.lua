local Robot = {}
function Robot:new()
    local robot = { name = "" }
    setmetatable(robot, self)
    self.__index = self
    return robot:reset()
end
function Robot:reset()
    self.name = string.format(
        '%s%s%i',
        string.char(math.floor(math.random() * 26) + 97),
        string.char(math.floor(math.random() * 26) + 97),
        math.floor(math.random() * 900) + 100
    )
    return self
end
return Robot