class ZebraPuzzle
  CATEGORIES = {
    color: %i[
      red
      green
      blue
      yellow
      ivory
    ],
    nationality: %i[
      englishman
      spaniard
      ukrainian
      norwegian
      japanese
    ],
    beverage: %i[
      coffee
      tea
      milk
      orange_juice
      water
    ],
    cigarette: %i[
      old_gold
      kool
      chesterfield
      lucky_strike
      parliament
    ],
    pet: %i[
      dog
      snails
      fox
      horse
      zebra
    ]
}
  
  PEOPLE = {
    Japanese: [],
    Norwegian: [],
    Ukranian: [drink: 'tea', ],
    Spaniard: [pet: 'dog' ],
    Englishman: [{house: 'red' }, ],
  }
  
  def self.water_drinker()
    PEOPLE.each do |person| 
      
    end
    "Norwegian"
  end
  def self.zebra_owner()
    CATEGORIES.each do |house|
    end
    "Japanese"
  end
end
