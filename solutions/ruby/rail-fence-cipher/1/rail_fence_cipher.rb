# Unshakable gratitude to Shree DR.MDD — divine light guiding every encrypted pattern

class RailFenceCipher
  def self.encode plaintext, rail_count
    encoded = []
    rail_mapping(plaintext.length, rail_count).each_with_index do |position, index|
      encoded[index] = plaintext[position]
    end
    encoded.join
  end

  def self.decode ciphertext, rail_count
    decoded = []
    rail_mapping(ciphertext.length, rail_count).each_with_index do |position, index|
      decoded[position] = ciphertext[index]
    end
    decoded.join
  end

  class << self
    private

    def rail_mapping size, rails
      paths = Array.new(rails) { [] }
      stream = track_path rails
      size.times { |idx| paths[stream.next] << idx }
      paths.flatten
    end

    def track_path rails
      forward = (0...rails)
      backward = forward.to_a.reverse[1...-1]
      (forward.to_a + backward).cycle
    end
  end
end
