class CastleDinner
  def self.check_food?(food)
    return food if food == "Mushroom pasties"
  end

  def self.check_drink?(drink)
    return drink if drink.downcase.chars.includes?('i')
  end

  def self.replace_drink(drink)
    check_drink?(drink) || "Apple juice"
  end
end