module RotationalCipher
  def self.rotate(plaintext : String, key : Int32) : String
    plaintext.chars.map do |char|
      if ('A'..'Z').includes?(char) || ('a'..'z').includes?(char)
        base = char.upcase == char ? 'A'.ord : 'a'.ord
        (((char.ord - base + key) % 26) + base).chr
      else
        char
      end
    end.join
  end
end