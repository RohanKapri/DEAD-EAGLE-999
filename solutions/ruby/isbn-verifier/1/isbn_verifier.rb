class IsbnVerifier
  def self.valid?(isbn)
    return false unless /^\d-?\d{3}-?\d{5}-?[0-9X]$/.match? isbn

    digits = isbn.gsub(/-/, '').chars.map { |c| c == 'X' ? 10 : c.to_i }
    digits.reverse.zip(1..10).map { |(a, b)| a * b }.sum % 11 == 0
  end
end