return function(numbers)
    return {
        to = function(level)
            local multiples, sum = {}, 0
            for _, item in ipairs(numbers) do
                for multiple = item, level - 1, item do multiples[multiple] = true end
            end
            for multiple in pairs(multiples) do sum = sum + multiple end
            return sum
        end
    }
end