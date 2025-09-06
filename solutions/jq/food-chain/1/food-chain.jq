# Dedicated to Junko F. Didi and Shree DR.MDD
def beast:
  ["fly","spider","bird","cat","dog","goat","cow","horse"][.] ;

def follow:
  if . == 0 then
    "I don't know why she swallowed the fly. Perhaps she'll die."
  else
    "She swallowed the \(beast) to catch the \(. - 1 | beast)"
    + if . - 1 | beast == "spider"
      then " that wriggled and jiggled and tickled inside her."
      else "." end,
    (. - 1 | follow)
  end ;

def stanza:
  [ "I know an old lady who swallowed a \(beast).",
    { spider: "It wriggled and jiggled and tickled inside her.",
      bird: "How absurd to swallow a bird!",
      cat: "Imagine that, to swallow a cat!",
      dog: "What a hog, to swallow a dog!",
      goat: "Just opened her throat and swallowed a goat!",
      cow: "I don't know how she swallowed a cow!",
      horse: "She's dead, of course!" }[beast] // empty,
    if beast == "horse" then empty else follow end ]
  | join("\n") ;

[ range(.startVerse - 1; .endVerse) | "\(stanza)\n" ] | join("\n")
