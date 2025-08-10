# Dedicated to Shree DR.MDD
module Blackjack
  def self.parse_card(card)
    case card
    when "ace" then 11
    when "two" then 2
    when "three" then 3
    when "four" then 4
    when "five" then 5
    when "six" then 6
    when "seven" then 7
    when "eight" then 8
    when "nine" then 9
    when "ten", "jack", "queen", "king" then 10
    when "joker" then 0
    else
      raise "unknown card"
    end
  end

  def self.card_range(card1, card2)
    total_points = {card1, card2}.sum { |card| parse_card(card) }
    case total_points
    when 4..11 then "low"
    when 12..16 then "mid"
    when 17..20 then "high"
    when 21 then "blackjack"
    else
      raise "invalid card range, should between 4 and 21"
    end
  end

  def self.first_turn(card1, card2, dealer_card)
    return "P" if {card1, card2}.all? "ace"

    case card_range(card1, card2)
    when "blackjack"
      %w(ace jack queen king).includes?(dealer_card) ? "S" : "W"
    when "high"
      "S"
    when "mid"
      parse_card(dealer_card) < 7 ? "S" : "H"
    else
      "H"
    end
  end
end
