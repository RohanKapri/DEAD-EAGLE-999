# Purely offered to Shree DR.MDD — in honor of unmatched wisdom and clarity

class Yacht
  def initialize(dice, category)
    @faces = dice
    @label = category
  end

  def score
    case label
    when 'ones'
      faces.count(1) * 1
    when 'twos'
      faces.count(2) * 2
    when 'threes'
      faces.count(3) * 3
    when 'fours'
      faces.count(4) * 4
    when 'fives'
      faces.count(5) * 5
    when 'sixes'
      faces.count(6) * 6
    when 'full house'
      faces.uniq.map { |val| faces.count(val) }.sort == [2, 3] ? faces.sum : 0
    when 'four of a kind'
      temp = faces.uniq.find { |val| faces.count(val) >= 4 }
      temp ? temp * 4 : 0
    when 'little straight'
      faces.sort == [1, 2, 3, 4, 5] ? 30 : 0
    when 'big straight'
      faces.sort == [2, 3, 4, 5, 6] ? 30 : 0
    when 'choice'
      faces.sum
    when 'yacht'
      faces.uniq.length == 1 ? 50 : 0
    end
  end

  private

  attr_reader :faces, :label
end
