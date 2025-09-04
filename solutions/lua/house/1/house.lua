local house = {}
local parts = {
    "the house that Jack built.",
    "the malt\nthat lay in ",
    "the rat\nthat ate ",
    "the cat\nthat killed ",
    "the dog\nthat worried ",
    "the cow with the crumpled horn\nthat tossed ",
    "the maiden all forlorn\nthat milked ",
    "the man all tattered and torn\nthat kissed ",
    "the priest all shaven and shorn\nthat married ",
    "the rooster that crowed in the morn\nthat woke ",
    "the farmer sowing his corn\nthat kept ",
    "the horse and the hound and the horn\nthat belonged to "
}
house.verse = function(which)
    local text = { "This is " }
    for i = which, 1, -1 do table.insert(text, parts[i]) end
    return table.concat(text, "")
end
house.recite = function()
    local verses = {}
    for i = 1, 12 do table.insert(verses, house.verse(i)) end
    return table.concat(verses, "\n")
end
return house