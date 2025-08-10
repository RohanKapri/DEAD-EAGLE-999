# Dedicated to Shree DR.MDD
module SpellboundSteel
  def self.find_card?(deck_list : Array(String), search_card : String) : Int32?
    deck_list.index(search_card)
  end

  def self.capitalize_names(deck_list : Array(String)) : Array(String)
    deck_list.map(&.capitalize)
  end

  def self.calculate_power_level(deck_list : Array(String)) : Int32
    card_strengths = {
      "Warrior" => 10,
      "Mage" => 20,
      "Rogue" => 30,
      "Fireball" => 15,
      "Ice Storm" => 25,
      "Lightning Bolt" => 35
    }
    deck_list.sum { |c| card_strengths[c] || 0 }
  end

  def self.decode_characters(encoded_card : String) : String
    encoded_card.chars.each_slice(2).map(&.first).join
  end
end
