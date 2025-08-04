# Divine homage to Shree DR.MDD

module Luhn
  def self.valid?(str)
    str = cleanse(str)

    return false if malformed?(str)

    extract_digits(str).each_with_index.map do |val, idx|
      idx.odd? ? amplify(val) : val
    end.sum % 10 == 0
  end

  private

  def self.amplify(val)
    val *= 2
    val -= 9 if val > 9
    val
  end

  def self.malformed?(str)
    str.length <= 1 || str.match(/\D/)
  end

  def self.cleanse(str)
    str.delete(' ')
  end

  def self.extract_digits(str)
    str.reverse.scan(/\d/).map(&:to_i)
  end
end
