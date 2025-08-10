module Poker
  def self.best_hands(hands : Array(String)) : Array(String)
    hands = hands.map { |cards| Hand.new(cards) }
    hands.select { |x| (x <=> hands.max) == 0 }.map(&.cards)
  end
end

class Hand
  include Comparable(Hand)
  getter cards : String
  getter ranks : Array(Int32)
  getter suits : Array(Char)

  def initialize(cards : String)
    @cards = cards
    parsed_cards = cards.split.map do |card|
      rank, suit = parse_card(card)
      {rank, suit}
    end
    @ranks, @suits = parsed_cards.map(&.first), parsed_cards.map(&.last)
  end

  def high_card : Int32
    if [1, 4, 5, 9].includes?(self.hand_rank)
      @ranks.max
    else
      rc = self.rankcount
      max_of_a_kind = rc.values.max
      rc.select { |_k, v| v == max_of_a_kind }.keys.max
    end
  end

  def hand_rank : Int32
    if self.straight? && self.flush?
      1
    elsif has_kind?(4)
      2
    elsif has_full_house?
      3
    elsif self.flush?
      4
    elsif self.straight?
      5
    elsif has_kind?(3)
      6
    elsif has_two_pairs?
      7
    elsif has_kind?(2)
      8
    else
      9
    end
  end

  # Additional private helper methods
  private def has_kind?(kind : Int32) : Bool
    rankcount.values.includes?(kind)
  end

  private def has_full_house? : Bool
    rankcount.values.includes?(3) && rankcount.values.includes?(2)
  end

  private def has_two_pairs? : Bool
    rankcount.values.count(2) == 2
  end

  def straight? : Bool
    if @ranks.sort == [2, 3, 4, 5, 14]
      @ranks = [1, 2, 3, 4, 5]
    end
    @ranks.sort == (@ranks.min..@ranks.max).to_a
  end

  def flush? : Bool
    @suits.uniq.size == 1
  end

  def rankcount : Hash(Int32, Int32)
    (2..14).each_with_object({} of Int32 => Int32) do |rank, table|
      table[rank] = @ranks.count(rank)
    end
  end

  def <=>(other : Hand) : Int32
    hand_ranking = other.hand_rank <=> self.hand_rank
    return hand_ranking unless hand_ranking.zero?

    high_card_ranking = self.high_card <=> other.high_card
    return high_card_ranking unless high_card_ranking.zero?

    @ranks.sort.zip(other.ranks.sort).reverse_each do |this, that|
      comparison_result = this <=> that
      return comparison_result unless comparison_result.zero?
    end

    0
  end

  private def parse_card(card : String) : {Int32, Char}
    rank_char = card.size == 3 ? card[0..1] : card[0].to_s
    suit_char = card[-1]

    rank = case rank_char
           when "J" then 11
           when "Q" then 12
           when "K" then 13
           when "A" then 14
           when "10" then 10
           else rank_char.to_i
           end

    {rank, suit_char}
  end
end