local all_your_base = {}
all_your_base.convert = function(from_digits, from_base)
    assert(from_base >= 2, 'invalid input base')
    local value = 0
    for d = 1, #from_digits do
        assert(from_digits[d] >= 0, 'negative digits are not allowed')
        assert(from_digits[d] < from_base, 'digit out of range')
        value = value * from_base + from_digits[d]
    end
    return {
        to = function(to_base)
            assert(to_base >= 2, 'invalid output base')
            if (value == 0) then return { 0 } end
            local to_digits = {}
            while (value > 0) do
                table.insert(to_digits, 1, (value % to_base))
                value = math.floor(value / to_base)
            end
            return to_digits
        end
    }
end
return all_your_base