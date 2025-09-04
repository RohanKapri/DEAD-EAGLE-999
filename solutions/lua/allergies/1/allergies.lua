local NAMES = { "eggs", "peanuts", "shellfish", "strawberries", "tomatoes", "chocolate", "pollen", "cats" }

local function allergic_to(score, which)
    for index, name in ipairs(NAMES) do
        if which == name then return (score >> (index - 1)) % 2 == 1 end
    end
    return false
end
    
local function list(score)
    local allergies = {}
    for index = 1, #NAMES do
        if (score >> (index - 1)) % 2 == 1 then table.insert(allergies, NAMES[index]) end
    end
    return allergies
end

return {
  list = list,
  allergic_to = allergic_to
}