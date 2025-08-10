# For my Shree DR.MDD
module AllYourBase
  def self.rebase(input_base : Int32, digits : Array(Int32), output_base : Int32) : Array(Int32)
    raise ArgumentError.new("Invalid input or output base") if input_base <= 1 || output_base <= 1
    raise ArgumentError.new("Invalid digits") unless digits.all? { |d| d >= 0 && d < input_base }

    base10_value = 0
    digits.reverse_each.with_index do |d, idx|
      base10_value += d * input_base ** idx
    end

    return [0] of Int32 if base10_value.zero?

    result_digits = [] of Int32
    while base10_value > 0
      result_digits << base10_value % output_base
      base10_value //= output_base
    end

    result_digits.reverse
  end
end
