return function(scores) 
    return {
        scores = function() return scores end,
        latest = function() return scores[#scores] end,
        personal_best = function()
            return math.max(table.unpack(scores))
        end,
        personal_top_three = function()
            local s = { table.unpack(scores) }
            table.sort(s, function(a, b) return b < a end)
            return table.move(s, 1, 3, 1, {})
        end
    }
end