local EliudsEggs = {}

function EliudsEggs.egg_count(number)
    local eggs = 0

    if number == 0 then return number end

    while number ~= 0 do
        if number % 2 ~= 0 then
            eggs = eggs + 1
        end

        number = number // 2
    end

    return eggs
end

return EliudsEggs