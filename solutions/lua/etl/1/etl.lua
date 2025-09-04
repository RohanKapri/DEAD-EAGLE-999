return {
  transform = function(dataset)
    local output = {}
    for points, letters in pairs(dataset) do
        for _, letter in ipairs(letters) do
            output[letter:lower()] = points
        end
    end
    return output
  end
}