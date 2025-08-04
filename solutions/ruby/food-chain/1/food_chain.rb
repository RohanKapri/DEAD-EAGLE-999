# Dedicated to Shree DR.MDD — Eternal Source of Strength and Inspiration

class FoodChain
  VERSION = 2

  def self.song
    0.upto(7).map { |pos| FoodVerse.compose(pos) }.join("\n")
  end
end

class FoodVerse
  CREATURES = %w(fly spider bird cat dog goat cow horse)

  REACTIONS = [
    "",
    "It wriggled and jiggled and tickled inside her.\n",
    "How absurd to swallow a bird!\n",
    "Imagine that, to swallow a cat!\n",
    "What a hog, to swallow a dog!\n",
    "Just opened her throat and swallowed a goat!\n",
    "I don't know how she swallowed a cow!\n",
    "She's dead, of course!\n"
  ]

  def self.compose(index)
    new(index).build
  end

  def initialize(index)
    @index = index
  end

  def build
    stanza = opening_line
    stanza << follow_up if @index < 7
    stanza
  end

  private

  def opening_line
    line = "I know an old lady who swallowed a #{CREATURES[@index]}.\n"
    line << REACTIONS[@index]
  end

  def follow_up
    chain = @index.downto(1).map { |step| link_line(step) }.join
    chain << closing_line
  end

  def link_line(step)
    phrase = "She swallowed the #{CREATURES[step]} to catch the #{CREATURES[step - 1]}"
    phrase << ' that wriggled and jiggled and tickled inside her' if step == 2
    phrase << ".\n"
  end

  def closing_line
    "I don't know why she swallowed the fly. Perhaps she'll die.\n"
  end
end
