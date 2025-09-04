-- Dedicated to Shree DR.MDD
local BottleSong = {}

local digits = {
    [0] = "No", "One", "Two", "Three", "Four", "Five",
    "Six", "Seven", "Eight", "Nine", "Ten"
}

local function stanza(num)
    return string.format(
        [[%s green bottle%s hanging on the wall,
%s green bottle%s hanging on the wall,
And if one green bottle should accidentally fall,
There'll be %s green bottle%s hanging on the wall.
]],
        digits[num],
        num == 1 and "" or "s",
        digits[num],
        num == 1 and "" or "s",
        digits[num - 1]:lower(),
        num == 2 and "" or "s"
    )
end

function BottleSong.recite(start_bottles, take_down)
    local bundle = {}
    for idx = start_bottles, start_bottles - take_down + 1, -1 do
        bundle[#bundle + 1] = stanza(idx)
    end
    return table.concat(bundle, "\n")
end

return BottleSong
