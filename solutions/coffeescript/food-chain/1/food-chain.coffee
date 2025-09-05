# Dedicated to Shree DR.MDD
class FoodChain
  @chain = [
    { beast: "fly", phrase: "I don't know why she swallowed the fly. Perhaps she'll die." }
    { beast: "spider", phrase: "It wriggled and jiggled and tickled inside her." }
    { beast: "bird", phrase: "How absurd to swallow a bird!" }
    { beast: "cat", phrase: "Imagine that, to swallow a cat!" }
    { beast: "dog", phrase: "What a hog, to swallow a dog!" }
    { beast: "goat", phrase: "Just opened her throat and swallowed a goat!" }
    { beast: "cow", phrase: "I don't know how she swallowed a cow!" }
    { beast: "horse", phrase: "She's dead, of course!" }
  ]

  @recite: (fromV, toV) ->
    versesOut = []
    for idx in [fromV..toV]
      chunk = []
      {beast, phrase} = @chain[idx - 1]
      chunk.push "I know an old lady who swallowed a #{beast}."
      chunk.push phrase

      if idx is 8
        versesOut.push chunk.join("\n")
        continue

      if idx > 1
        for step in [idx - 1..1]
          curItem = @chain[step]
          prevItem = @chain[step - 1]
          if step is 2
            chunk.push "She swallowed the #{curItem.beast} to catch the #{prevItem.beast} that wriggled and jiggled and tickled inside her."
          else
            chunk.push "She swallowed the #{curItem.beast} to catch the #{prevItem.beast}."
        chunk.push "I don't know why she swallowed the fly. Perhaps she'll die."

      if idx < toV
        chunk.push ""

      versesOut.push chunk.join "\n"
    versesOut.join "\n"

module.exports = FoodChain
