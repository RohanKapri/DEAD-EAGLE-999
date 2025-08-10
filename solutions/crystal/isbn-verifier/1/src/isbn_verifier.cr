module IsbnVerifier
  def self.valid?(isbn : String) : Bool
    # Validate format and capture digits/X
    matches = isbn.match(/^(\d)-?(\d{3})-?(\d{5})-?([\dX])$/)
    return false unless matches

    digits = matches[1..4].join.chars

    # Calculate checksum
    checksum = digits.each_with_index.sum do |char, index|
      value = char == 'X' ? 10 : char.to_i
      value * (10 - index)
    end

    checksum % 11 == 0
  end
end