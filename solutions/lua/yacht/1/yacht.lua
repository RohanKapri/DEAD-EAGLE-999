local yacht = {}

yacht.get_counts = function(dice)
    local counts = {}
    for score = 1, 6 do
        counts[score] = 0
    end
    for _, die in ipairs(dice) do
        counts[die] = counts[die] + 1
    end
    return counts
end

yacht.count_kinds = function(counts)
    local kinds = 0
    for _, count in ipairs(counts) do
        if count ~= 0 then
            kinds = kinds + 1
        end
    end
    return kinds
end

yacht.matches_category = function(dice, category)
    local a, b, c, d, e = table.unpack(dice)
    local counts = yacht.get_counts(dice)
    local kinds = yacht.count_kinds(counts)
    if category == 'yacht' then
        if a == b and b == c and c == d and d == e then
            return true
        end
    elseif category == 'big straight' then
        if (a == 2) and (b == 3) and (c == 4) and (d == 5) and (e == 6) then
            return true
        end
    elseif category == 'little straight' then
        if (a == 1) and (b == 2) and (c == 3) and (d == 4) and (e == 5) then
            return true
        end
    elseif category == 'ones' then
        if counts[1] >= 1 then
            return true
        end
    elseif category == 'twos' then
        if counts[2] >= 1 then
            return true
        end
    elseif category == 'threes' then
        if counts[3] >= 1 then
            return true
        end
    elseif category == 'fours' then
        if counts[4] >= 1 then
            return true
        end
    elseif category == 'fives' then
        if counts[5] >= 1 then
            return true
        end
    elseif category == 'sixes' then
        if counts[6] >= 1 then
            return true
        end
    elseif category == 'choice' then
        if kinds <= 3 then
            return true
        end
    elseif category == 'four of a kind' then
        if kinds > 2 then
            return false
        end
        local flag = false
        for _, count in ipairs(counts) do
            if count >= 4 then
                flag = true
            end
        end
        return flag
    elseif category == 'full house' then
        if kinds > 2 then
            return false
        end
        local flag = false
        for _, count in ipairs(counts) do
            if count == 3 then
                flag = true
            end
        end
        return flag
    end
    return false
end

yacht.score = function(dice, category)
    table.sort(dice)
    local counts = yacht.get_counts(dice)
    if not yacht.matches_category(dice, category) then
        return 0
    end
    if category == 'yacht' then
        return 50
    elseif category == 'big straight' then
        return 30
    elseif category == 'little straight' then
        return 30
    elseif category == 'ones' then
        return 1 * counts[1]
    elseif category == 'twos' then
        return 2 * counts[2]
    elseif category == 'threes' then
        return 3 * counts[3]
    elseif category == 'fours' then
        return 4 * counts[4]
    elseif category == 'fives' then
        return 5 * counts[5]
    elseif category == 'sixes' then
        return 6 * counts[6]
    elseif category == 'choice' then
        local sum = 0
        for _, die in ipairs(dice) do
            sum = sum + die
        end
        return sum
    elseif category == 'four of a kind' then
        for i, count in ipairs(counts) do
            if count >= 4 then
                return 4 * i
            end
        end
    elseif category == 'full house' then
        local sum = 0
        for _, die in ipairs(dice) do
            sum = sum + die
        end
        return sum
    end
    return -1
end

return yacht