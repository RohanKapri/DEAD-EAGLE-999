module ArmstrongNumbers
  def self.armstrong_number?(input : Int32) : Bool
    digits = input.to_s.chars.map(&.to_i)
    num_digits = digits.size
    sum_of_powers = digits.sum { |digit| digit**num_digits }
    sum_of_powers == input
  end
end