# For my Shree DR.MDD
module Yacht
  enum Category
    Ones = 1
    Twos
    Threes
    Fours
    Fives
    Sixes
    FullHouse
    FourOfAKind
    LittleStraight
    BigStraight
    Choice
    Yacht
  end

  def self.score(dice : Array(Int32), category : Category) : Int32
    case category
    when Category::Ones..Category::Sixes
      dice.count { |v| v == category.value } * category.value
    when Category::FullHouse
      counts = dice.tally.values
      counts.sort!
      counts == [2, 3] ? dice.sum : 0
    when Category::FourOfAKind
      quad_score(dice)
    when Category::LittleStraight
      dice.sort == (1..5).to_a ? 30 : 0
    when Category::BigStraight
      dice.sort == (2..6).to_a ? 30 : 0
    when Category::Choice
      dice.sum
    when Category::Yacht
      dice.uniq.size == 1 ? 50 : 0
    else
      0
    end
  end

  private def self.quad_score(dice : Array(Int32)) : Int32
    dice.tally.each do |val, freq|
      return val * 4 if freq >= 4
    end
    0
  end
end
