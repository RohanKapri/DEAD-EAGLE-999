local function count_words(s)
  local words = {}
  for word in (s or ""):lower():gmatch("[%a%d']+") do
    word = word:match("^'?(.-)'?$")
    if word and #word > 0 then
      words[word] = (words[word] or 0) + 1
    end
  end
  return words
end

return { count_words = count_words }