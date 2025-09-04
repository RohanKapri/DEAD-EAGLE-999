local function flatten(input, accumulator)
  accumulator = accumulator or {}
  for _, element in ipairs(input) do
    if type(element) == 'table' then
      flatten(element, accumulator)
    else
      table.insert(accumulator, element)
    end
  end
  return accumulator
end

return flatten