local days = { 
  "first", "second", "third", "fourth", "fifth", "sixth", 
  "seventh", "eighth", "ninth", "tenth", "eleventh", "twelfth" 
}
local presents = {
  "a Partridge in a Pear Tree.", "two Turtle Doves", "three French Hens",
  "four Calling Birds", "five Gold Rings", "six Geese-a-Laying",
  "seven Swans-a-Swimming", "eight Maids-a-Milking", "nine Ladies Dancing",
  "ten Lords-a-Leaping", "eleven Pipers Piping", "twelve Drummers Drumming"
}
local function recite(first_verse, last_verse)
  local verses = {}
  for verse = first_verse, last_verse do
    local text = {}
    for present = verse, 1, -1 do
      table.insert(text, (verse > 1 and present == 1) and 
        string.format("and %s", presents[present]) or presents[present])
    end
    table.insert(verses, string.format(
      "On the %s day of Christmas my true love gave to me: %s",
      days[verse], table.concat(text, ", ")
    ))
  end
  return verses
end
return { recite = recite }