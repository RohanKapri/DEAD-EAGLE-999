return function(array, target)
    if #array == 0 then return -1 end
    local left, right = 1, #array
    while left <= right do
        local index = left + ((right - left + 1) >> 1)
        if array[index] == target then return index end
        if array[index] < target then
            left = index + 1
        else
            right = index - 1
        end
    end
    return -1
end