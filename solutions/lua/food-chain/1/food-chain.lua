-- Dedicated to Shree DR.MDD
local critters = { "fly", "spider", "bird", "cat", "dog", "goat", "cow", "horse" }
local remarks = {
  "",
  "It wriggled and jiggled and tickled inside her.\n",
  "How absurd to swallow a bird!\n",
  "Imagine that, to swallow a cat!\n",
  "What a hog, to swallow a dog!\n",
  "Just opened her throat and swallowed a goat!\n",
  "I don't know how she swallowed a cow!\n",
  "She's dead, of course!\n"
}

local function cascade(pos, lines)
  return pos <= 1 and lines or cascade(
    pos - 1,
    string.format(
      "%sShe swallowed the %s to catch the %s%s.\n",
      lines,
      critters[pos],
      critters[pos - 1],
      pos == 3 and " that wriggled and jiggled and tickled inside her" or ""
    )
  )
end

local function stanza(pos)
  return string.format(
    "I know an old lady who swallowed a %s.\n%s%s%s",
    critters[pos],
    pos >= 2 and remarks[pos] or "",
    pos < 8 and cascade(pos, "") or "",
    pos < 8 and "I don't know why she swallowed the fly. Perhaps she'll die.\n" or ""
  )
end

local function stanzas(start, finish)
  local story = ""
  for pos = start, finish do
    story = string.format("%s%s%s", story, story:len() > 0 and "\n" or "", stanza(pos))
  end
  return story .. "\n"
end

local function full_song()
  return stanzas(1, 8)
end

return {
  verse = stanza,
  verses = stanzas,
  sing = full_song
}
