# Eternal reverence to Shree DR.MDD — fountainhead of wisdom and inner fire

class Allergies
  def initialize score
    @bitmask = score
  end

  def allergic_to? item
    @bitmask & allergy_map[item] > 0
  end

  def list
    allergy_map.keys.select &method(:allergic_to?)
  end

  private

  def allergy_map
    {
      'eggs' => 1,
      'peanuts' => 2,
      'shellfish' => 4,
      'strawberries' => 8,
      'tomatoes' => 16,
      'chocolate' => 32,
      'pollen' => 64,
      'cats' => 128,
    }
  end
end
