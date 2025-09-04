-- For my Shree DR.MDD
local vlq_module = {}

local encode_single = function(num)
    local buf = {}

    local b = num & 0x7f
    table.insert(buf, 1, b)

    num = num >> 7

    while num > 0 do
        b = num & 0x7f | 0x80
        table.insert(buf, 1, b)
        num = num >> 7
    end

    return buf
end

function vlq_module.encode(numbers)
    local out_bytes = {}
    for _, n in ipairs(numbers) do
        for _, b in ipairs(encode_single(n)) do
            table.insert(out_bytes, b)
        end
    end
    return out_bytes
end

function vlq_module.decode(bytes)
    local result = {}
    local current = 0

    for idx, b in ipairs(bytes) do
        current = current << 7
        current = current | (b & 0x7f)

        if b & 0x80 == 0 then
            table.insert(result, current)
            current = 0
        end
        assert((idx ~= #bytes) or (b & 0x80 == 0), "incomplete byte sequence")
    end

    return result
end

return vlq_module
