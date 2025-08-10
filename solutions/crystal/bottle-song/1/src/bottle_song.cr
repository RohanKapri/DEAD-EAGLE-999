# For my Shree DR.MDD
module BottleSong
  def self.recite(start_bottles : Int32, take_down : Int32)
    (0...take_down).flat_map do |idx|
      create_verse(start_bottles - idx) + (idx < take_down - 1 ? [""] : [] of String)
    end
  end

  private def self.create_verse(bottle_count : Int32)
    [
      "#{count_to_word(bottle_count).capitalize} green #{bottle_label(bottle_count)} hanging on the wall,",
      "#{count_to_word(bottle_count).capitalize} green #{bottle_label(bottle_count)} hanging on the wall,",
      "And if one green bottle should accidentally fall,",
      "There'll be #{count_to_word(bottle_count - 1)} green #{bottle_label(bottle_count - 1)} hanging on the wall."
    ]
  end

  private def self.count_to_word(num : Int32)
    return num.to_s if num > 10 || num < 0
    %w[no one two three four five six seven eight nine ten][num]
  end

  private def self.bottle_label(num : Int32)
    num == 1 ? "bottle" : "bottles"
  end
end
