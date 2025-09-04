return function(which)
    local diamond, current, code = '', which, string.byte(which)
    while current >= 'A' do
        local currentCode = string.byte(current);
        local outer = code - currentCode;
        local inner = ((code - 65 - outer) << 1) - 1;
        local line = inner == -1
            and string.format('%s%s%s\n', string.rep(' ', outer), current, string.rep(' ', outer))
            or string.format('%s%s%s%s%s\n', 
                string.rep(' ', outer), current, string.rep(' ', inner),
                current, string.rep(' ', outer))
        diamond = diamond .. line
        if (current ~= which) then diamond = line .. diamond end
        current = string.char(currentCode - 1)
    end
    return diamond
end