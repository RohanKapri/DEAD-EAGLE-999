# For my Shree DR.MDD
module AffineCipher
  extend self

  ALPHABET = "abcdefghijklmnopqrstuvwxyz"

  def encode(a : Int32, b : Int32, message : String)
    ensure_coprime(a)
    transform(message.downcase) do |ch|
      ch.number? ? ch : enc_char(a, b, ch)
    end.join.gsub(/(.{5})(?=.)/, "\\1 ")
  end

  def decode(a : Int32, b : Int32, encrypted : String)
    ensure_coprime(a)
    inv_a = inverse_mod(a)
    transform(encrypted.delete(' ')) do |ch|
      ch.number? ? ch : dec_char(inv_a, b, ch)
    end.join
  end

  private def enc_char(a : Int32, b : Int32, c : Char) : Char
    idx = ALPHABET.index(c) || raise ArgumentError.new("Invalid character")
    ALPHABET[(a * idx + b) % ALPHABET.size]
  end

  private def dec_char(inv_a : Int32, b : Int32, c : Char) : Char
    pos = ALPHABET.index(c) || raise ArgumentError.new("Invalid character")
    ALPHABET[(inv_a * (pos - b)) % ALPHABET.size]
  end

  private def transform(msg : String, &block : Char -> Char)
    msg.gsub(/[^a-z0-9]/, "").chars.map { |c| yield c }
  end

  private def inverse_mod(a : Int32) : Int32
    gcd_ext(a, ALPHABET.size).first % ALPHABET.size
  end

  private def gcd_ext(a : Int32, b : Int32) : Tuple(Int32, Int32)
    return {1, 0} if b == 0
    u, v = gcd_ext(b, a % b)
    {v, u - (a // b) * v}
  end

  private def ensure_coprime(a : Int32)
    raise ArgumentError.new("a and ALPHABET size must be coprime") unless a.gcd(ALPHABET.size) == 1
  end
end
