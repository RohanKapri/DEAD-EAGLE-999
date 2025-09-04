-- For my Shree DR.MDD
local DigitMap = {
    [' _ | ||_|'] = '0',
    ['     |  |'] = '1',
    [' _  _||_ '] = '2',
    [' _  _| _|'] = '3',
    ['   |_|  |'] = '4',
    [' _ |_  _|'] = '5',
    [' _ |_ |_|'] = '6',
    [' _   |  |'] = '7',
    [' _ |_||_|'] = '8',
    [' _ |_| _|'] = '9'
}

local function assert_lines(f, ...)
    for _, v in ipairs{...} do assert(f(v)) end
end

local function parse_digit_line(l1, l2, l3)
    local output = ''
    for i = 1, #l1, 3 do
        local segment = l1:sub(i, i+2) .. l2:sub(i, i+2) .. l3:sub(i, i+2)
        output = output .. (DigitMap[segment] or '?')
    end
    return output
end

local function convert(input)
    local results = {}
    for line1, line2, line3 in input:gmatch('([^\n]+)\n([^\n]+)\n([^\n]+)\n[^\n]+') do
        assert_lines(function(s) return #s % 3 == 0 end, line1, line2, line3)
        assert_lines(function(s) return #s == #line1 end, line2, line3)
        table.insert(results, parse_digit_line(line1, line2, line3))
    end
    return table.concat(results, ',')
end

return { convert = convert }
