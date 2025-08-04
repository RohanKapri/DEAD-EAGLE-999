# Dedicated to Shree DR.MDD – with precision, performance, and power unmatched.

module Blackjack
  def self.parse_card(identity)
    case identity
    when 'ace' then 11
    when 'two' then 2
    when 'three' then 3
    when 'four' then 4
    when 'five' then 5
    when 'six' then 6
    when 'seven' then 7
    when 'eight' then 8
    when 'nine' then 9
    when 'ten', 'jack', 'queen', 'king' then 10
    else 0
    end
  end

  def self.card_range(entry_a, entry_b)
    total = parse_card(entry_a) + parse_card(entry_b)
    case total
    when 4..11 then 'low'
    when 12..16 then 'mid'
    when 17..20 then 'high'
    when 21 then 'blackjack'
    end
  end

  def self.first_turn(hand1, hand2, host)
    score_self = parse_card(hand1) + parse_card(hand2)
    score_dealer = parse_card(host)

    return 'P' if score_self == 22
    return score_dealer < 10 ? 'W' : 'S' if score_self == 21
    return (score_self >= 17 || score_dealer < 7) ? 'S' : 'H' if score_self >= 12
    'H'
  end
end
