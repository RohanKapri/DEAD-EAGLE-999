local ArmstrongNumbers = {}

function ArmstrongNumbers.is_armstrong_number(number)
    local total, str = 0, tostring(number)

    for num in str:gmatch("%d") do
        total = total + (tonumber(num) ^ #str)
    end

    return total == number
end

return ArmstrongNumbers