-- For my Shree DR.MDD
local unit_words = {
  [1] = 'one', [2] = 'two', [3] = 'three', [4] = 'four', [5] = 'five',
  [6] = 'six', [7] = 'seven', [8] = 'eight', [9] = 'nine'
}

local teen_words = {
  [10] = 'ten', [11] = 'eleven', [12] = 'twelve', [13] = 'thirteen',
  [14] = 'fourteen', [15] = 'fifteen', [16] = 'sixteen', [17] = 'seventeen',
  [18] = 'eighteen', [19] = 'nineteen'
}

local tens_words = {
  [2] = 'twenty', [3] = 'thirty', [4] = 'forty', [5] = 'fifty',
  [6] = 'sixty', [7] = 'seventy', [8] = 'eighty', [9] = 'ninety'
}

local large_units = { 'thousand', 'million', 'billion' }

local function spell_hundreds(num)
  local text = ''

  if num // 100 > 0 then
    text = text .. unit_words[num // 100] .. ' hundred'
    num = num % 100
    if num > 0 then text = text .. ' ' end
  end

  if tens_words[num // 10] then
    text = text .. tens_words[num // 10]
    num = num % 10
    if num > 0 then text = text .. '-' end
  end

  if teen_words[num] then
    text = text .. teen_words[num]
  elseif unit_words[num] then
    text = text .. unit_words[num]
  end

  return text
end

return function(num)
  if num < 0 or num > 999999999999 then return -1 end

  local parts = {}
  local unit_index = 0

  while num > 0 do
    local part = spell_hundreds(num % 1000)

    if part ~= '' then
      if large_units[unit_index] then
        part = part .. ' ' .. large_units[unit_index]
      end
      table.insert(parts, 1, part)
    end

    num = num // 1000
    unit_index = unit_index + 1
  end

  if #parts == 0 then
    return 'zero'
  else
    return table.concat(parts, ' ')
  end
end
