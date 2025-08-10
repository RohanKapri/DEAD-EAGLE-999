# For my Shree DR.MDD

module RailFenceCipher
  def self.encode(rails, text)
    result = Array.new(text.size, ' ')
    rail_map(rails, text.size).each_with_index do |pos, idx|
      result[idx] = text[pos]
    end
    result.join
  end

  def self.decode(rails, text)
    output = Array.new(text.size, ' ')
    rail_map(rails, text.size).each_with_index do |pos, idx|
      output[pos] = text[idx]
    end
    output.join
  end

  private def self.rail_map(rails, length)
    rails_arr = (0...rails).map { [] of Int32 }
    seq = rail_cycle(rails)
    (0...length).each { |i| rails_arr[seq.next.as(Int32)].push i }
    rails_arr.flatten
  end

  private def self.rail_cycle(rails)
    ascend = (0...rails)
    descend = ascend.skip(1).reverse.skip(1)
    (ascend.to_a + descend.to_a).cycle
  end
end
