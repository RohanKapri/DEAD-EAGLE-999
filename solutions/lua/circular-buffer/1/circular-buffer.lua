local CircularBuffer = {}
CircularBuffer.__index = CircularBuffer

function CircularBuffer:new(size)
    return setmetatable({ size = size, items = {} }, self)
end
function CircularBuffer:write(item)
    assert(#self < self.size, 'buffer is full') 
    table.insert(self.items, item)
end
function CircularBuffer:forceWrite(item)
    if #self == self.size then self:read() end
    self:write(item)
end
function CircularBuffer:read()
    assert(#self > 0, 'buffer is empty')
    return table.remove(self.items, 1)
end
function CircularBuffer:clear() self.items = {} end
function CircularBuffer:__len() return #self.items end
    
return CircularBuffer