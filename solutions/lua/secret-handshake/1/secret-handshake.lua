local actions = {
    "wink",
    "double blink",
    "close your eyes",
    "jump"
}
    
return function(n)
    local handshake, reverse = {}, n & 16 == 16
    for index, action in ipairs(actions) do
        if n & (1 << (index - 1)) ~= 0 then
            table.insert(handshake, reverse and 1 or #handshake + 1, action)
        end
    end
    return handshake
end