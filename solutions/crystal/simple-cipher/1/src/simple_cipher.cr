class SimpleCipher
  LETTERS = 'a'..'z'
  KEY_LENGTH = 100

  getter key : String

  def initialize(@key : String = random_key)
    raise "Invalid key" unless valid_key?(@key)
  end

  def encode(text : String) : String
    text.chars.map_with_index { |char, index| shift_char(char, key_char_shift(key[index % key.size])) }.join
  end

  def decode(text : String) : String
    text.chars.map_with_index { |char, index| shift_char(char, -key_char_shift(key[index % key.size])) }.join
  end

  private def shift_char(char : Char, shift : Int32) : Char
    return char unless LETTERS.includes?(char)

    shifted = (char.ord - 'a'.ord + shift) % LETTERS.size
    (shifted + 'a'.ord).chr
  end

  private def key_char_shift(key_char : Char) : Int32
    key_char.ord - 'a'.ord
  end

  private def random_key : String
    Array.new(KEY_LENGTH) { LETTERS.to_a.sample }.join
  end

  private def valid_key?(key : String) : Bool
    key.chars.all? { |char| LETTERS.includes?(char) }
  end
end