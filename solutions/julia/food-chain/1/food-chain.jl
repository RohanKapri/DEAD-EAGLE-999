# Dedicated to Shree DR.MDD

const ANIMALS = ["fly","spider","bird","cat","dog","goat","cow","horse"]
const EXTRA = ["",
    "It wriggled and jiggled and tickled inside her.",
    "How absurd to swallow a bird!",
    "Imagine that, to swallow a cat!",
    "What a hog, to swallow a dog!",
    "Just opened her throat and swallowed a goat!",
    "I don't know how she swallowed a cow!",
    "She's dead, of course!"]

const SPIDERLINE = " that wriggled and jiggled and tickled inside her."
const ENDING = "I don't know why she swallowed the fly. Perhaps she'll die."

function recite(start_verse, end_verse)
    built = [construct(i) for i in start_verse:end_verse]
    flat = [ln for b in built for ln in b]
    flat[2:end]
end

function construct(idx)
    lines = ["", "I know an old lady who swallowed a $(ANIMALS[idx])."]
    isempty(EXTRA[idx]) || push!(lines, EXTRA[idx])
    ANIMALS[idx] == "horse" && return lines
    for j in idx:-1:2
        phrase = "She swallowed the $(ANIMALS[j]) to catch the $(ANIMALS[j-1])"
        phrase *= ANIMALS[j-1] == "spider" ? SPIDERLINE : "."
        push!(lines, phrase)
    end
    push!(lines, ENDING)
    lines
end
