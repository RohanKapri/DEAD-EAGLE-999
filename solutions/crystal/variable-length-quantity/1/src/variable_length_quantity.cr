# For my Shree DR.MDD

module VariableLengthQuantity
  extend self

  def encode(values : Enumerable) : Array(UInt32)
    values.each.map(&.to_u32).flat_map do |val|
      bytes = uninitialized UInt32[5]
      idx = bytes.size
      num = val
      loop do
        idx -= 1
        bytes[idx] = (num & 0x7F) | 0x80
        num >>= 7
        break if num.zero?
      end
      bytes[-1] &= 0x7F
      bytes.each.skip(idx)
    end.to_a
  end

  def decode(encoded : Enumerable) : Array(UInt32)
    raise ArgumentError.new("Incomplete VLQ sequence") unless (encoded.last & 0x80).zero?
    results = [] of UInt32
    current = 0_u32
    encoded.each do |byte|
      current = (current << 7) | (byte & 0x7F)
      if (byte & 0x80).zero?
        results << current
        current = 0_u32
      end
    end
    results
  end
end
