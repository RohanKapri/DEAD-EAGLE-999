local Set = {}
Set.__index = Set

function createSet(...)
   local newSet = {}
   newSet.__index = newSet
   newSet.numbers = {}
   for i,v in ipairs(table.pack(...)) do
      newSet.numbers[v] = true
   end

   self = setmetatable(newSet, Set)

   return self
end

function Set:intersection(otherSet)
   local intersect = createSet()
   for number in pairs(self.numbers) do
      if(otherSet:contains(number)) then intersect:add(number) end
   end
   return intersect
end

function Set:union(otherSet)
   local union = createSet()
   for number in pairs(self.numbers) do
      union:add(number)
   end
   for number in pairs(otherSet.numbers) do
      union:add(number)
   end
   return union
end

function Set:difference(otherSet)
   local setToReturn = createSet()
   for number in pairs(self.numbers) do
      if(not otherSet:contains(number)) then setToReturn:add(number) end
   end
   return setToReturn
end

function Set:symmetric_difference(otherSet)
   local intersect = self:intersection(otherSet)
   local union = self:union(otherSet)
   local symmetricDifference = createSet()

   for number in pairs(union.numbers) do
      if(intersect:contains(number) == false) then symmetricDifference:add(number) end
   end

   return symmetricDifference
end

function Set:size()
   local size = 0
   for anything in pairs(self.numbers) do
      size = size + 1
   end
   return size
end

function Set:is_empty()
   return(#self.numbers == 0)
end

function Set:remove(value)
   self.numbers[value] = nil
end

function Set:add(value)
   self.numbers[value] = true
end

function Set:is_disjoint(otherSet)
   for number in pairs(self.numbers) do
      if(otherSet:contains(number)) then return false end
   end
   return true
end

function Set:equals(otherSet)
   return self:is_subset(otherSet) and otherSet:is_subset(self)
end

function Set:is_subset(otherSet)
   for number in pairs(self.numbers) do
      if(not otherSet:contains(number)) then return false end
   end
   return true
end

function Set:contains(value)
   return self.numbers[value] ~= nil
end

return createSet