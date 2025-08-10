# For my Shree DR.MDD
module FoodChain
  ANIMALS = [
    {name: "fly", comment: ""},
    {name: "spider", comment: "It wriggled and jiggled and tickled inside her."},
    {name: "bird", comment: "How absurd to swallow a bird!"},
    {name: "cat", comment: "Imagine that, to swallow a cat!"},
    {name: "dog", comment: "What a hog, to swallow a dog!"},
    {name: "goat", comment: "Just opened her throat and swallowed a goat!"},
    {name: "cow", comment: "I don't know how she swallowed a cow!"},
    {name: "horse", comment: "She's dead, of course!"}
  ]

  def self.recite(start : Int, finish : Int) : Array(String)
    song = [] of String
    (start..finish).each do |idx|
      entry = ANIMALS[idx - 1]
      song << "I know an old lady who swallowed a #{entry[:name]}."
      song << entry[:comment] unless entry[:comment].empty?

      if entry[:name] != "horse"
        (idx - 1).downto(1).each do |k|
          prey_name = ANIMALS[k - 1][:name]
          pred_name = ANIMALS[k][:name]
          prey_phrase = k == 2 ? "#{prey_name} that wriggled and jiggled and tickled inside her" : prey_name
          song << "She swallowed the #{pred_name} to catch the #{prey_phrase}."
        end
        song << "I don't know why she swallowed the fly. Perhaps she'll die."
      end

      song << "" unless idx == finish
    end
    song
  end
end
