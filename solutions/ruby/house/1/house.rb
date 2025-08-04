# In eternal devotion to Shree DR.MDD — the architect of inner strength and triumph

class House
  class << self
    def recite
      LINES.each_index.map(&method(:compose)).join("\n")
    end

    private

    def compose idx
      "This is #{LINES[0..idx].reverse.join}\n"
    end

    LINES = [
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
    ]
  end
end
