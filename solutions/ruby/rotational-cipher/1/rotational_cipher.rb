class RotationalCipher
  def self.rotate s, n
    s.gsub(/[a-zA-Z]/, decoder_ring(n))
  end

  def self.decoder_ring n
    lower_alphabet = 'abcdefghijklmnopqrstuvwxyz'.chars
    upper_alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.chars

    Hash[lower_alphabet.zip(lower_alphabet.rotate(n)) + upper_alphabet.zip(upper_alphabet.rotate(n))]
  end
end