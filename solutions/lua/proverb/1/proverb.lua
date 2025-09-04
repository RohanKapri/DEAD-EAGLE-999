local Proverb = {}

function Proverb.recite(strings)
  local verses = {}
  for pos, item in ipairs(strings) do
    verses[#verses + 1] = pos == #strings and
      string.format("And all for the want of a %s.\n", strings[1]) or
      string.format("For want of a %s the %s was lost.\n", item, strings[pos + 1])
  end
  return table.concat(verses, "")
end

return Proverb