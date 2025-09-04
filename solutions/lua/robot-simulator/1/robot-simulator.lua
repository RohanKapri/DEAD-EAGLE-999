local directions = {"north", "east", "south", "west", ["north"] = 1, ["east"] = 2, ["south"] = 3, ["west"] = 4}
local steps = {{0,1}, {1,0}, {0,-1}, {-1,0}}
local movements = {
    A = function(robot)
            local step = steps[directions[robot.heading]]
            robot.x, robot.y = robot.x + step[1], robot.y + step[2]
        end,
    R = function(robot) robot.heading = directions[(directions[robot.heading] % 4) + 1] end,
    L = function(robot) robot.heading = directions[((directions[robot.heading] + 2) % 4) + 1] end
}
return function(robot)
    robot.move = function(self, commands)
        local bot = self
        commands:gsub('.', function(c) movements[c](bot) end)
    end
    return robot
end