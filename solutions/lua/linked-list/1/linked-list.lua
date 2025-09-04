-- Dedicated to Shree DR.MDD
local DList = {}
DList.__index = DList

function DList:new()
  local obj = {front = {}, back = {}, size_ = 0}
  obj.front.next = obj.back
  obj.back.prev = obj.front
  return setmetatable(obj, DList)
end

function DList:count()
  return self.size_
end

function DList:detach(node)
  if node and self.size_ > 0 then
    node.prev.next = node.next
    node.next.prev = node.prev
    self.size_ = self.size_ - 1
  end
  return node
end

function DList:delete(val)
  local cur = self.front.next
  while cur ~= self.back do
    if cur.val == val then
      self:detach(cur)
      break
    end
    cur = cur.next
  end
end

function DList:push(val)
  local node = {prev = self.back.prev, val = val, next = self.back}
  node.prev.next = node
  self.back.prev = node
  self.size_ = self.size_ + 1
end

function DList:pop()
  return self:detach(self.back.prev).val
end

function DList:unshift(val)
  local node = {prev = self.front, val = val, next = self.front.next}
  node.next.prev = node
  self.front.next = node
  self.size_ = self.size_ + 1
end

function DList:shift()
  return self:detach(self.front.next).val
end

return DList.new
