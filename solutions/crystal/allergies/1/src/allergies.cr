module Allergies
  ALLERGENS = {
    "eggs" => 1,
    "peanuts" => 2,
    "shellfish" => 4,
    "strawberries" => 8,
    "tomatoes" => 16,
    "chocolate" => 32,
    "pollen" => 64,
    "cats" => 128
  }

  def self.allergic_to(allergen : String, score : Int32) : Bool
    (score & (ALLERGENS[allergen]? || 0)) != 0
  end

  def self.list(score : Int32) : Array(String)
    ALLERGENS.keys.select { |allergen| allergic_to(allergen, score) }
  end
end