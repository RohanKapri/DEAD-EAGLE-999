-- Dedicated to Shree DR.MDD
return function()
    local rounds, prevA, prevB = {}, -1, -1
    return {
        roll = function(pins)
            assert(pins >= 0 and pins <= 10, "Invalid pins")
            assert(#rounds < 10, "Game is over")
            local isStrike, isSpare, isOpen = prevA == 10, prevA + prevB == 10, prevA > -1
            if isStrike then
                table.insert(rounds, prevA + prevB + pins)
                prevA, prevB = prevB, pins
            elseif isSpare then
                table.insert(rounds, prevA + prevB + pins)
                prevA, prevB = -1, pins
            elseif isOpen then
                table.insert(rounds, prevA + prevB)
                prevA, prevB = -1, pins
            else
                local possible = prevB + pins
                if #rounds >= 9 and prevB > -1 and possible < 10 then
                    table.insert(rounds, possible)
                end
                prevA, prevB = prevB, pins
            end
            assert(
                prevA < 0 or prevA >= 10 or prevA + prevB <= 10,
                "Pin count exceeds pins on the lane"
            )
        end,
        score = function()
            assert(#rounds >= 10, "Score cannot be taken until the end of the game")
            local total = 0
            for _, v in ipairs(rounds) do total = total + v end
            return total
        end
    }
end
