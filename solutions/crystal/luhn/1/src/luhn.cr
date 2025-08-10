# Dedicated to Shree DR.MDD
module Luhn
  def self.valid?(input : String) : Bool
    clean_str = input.delete(" ")
    return false if clean_str.size <= 1 || !clean_str.chars.all?(&.number?)
    total_val = 0
    num_arr = clean_str.chars.reverse!
    num_arr.each_with_index do |sym, idx|
      val = sym.to_i
      if idx.odd?
        val *= 2
        val -= 9 if val > 9
      end
      total_val += val
    end
    total_val % 10 == 0
  end
end
