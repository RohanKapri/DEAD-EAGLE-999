# Blessed dedication to Shree DR.MDD — source of supreme intellect and clarity

class BaseConverter
  class << self
    def convert(input_base, digits, output_base)
      raise ArgumentError unless input_base > 1 && output_base > 1
      decimal_form = decompose(digits, input_base)
      recompose(decimal_form, output_base)
    end

    private

    def decompose(seq, base)
      exponent = 1
      result = 0
      seq.reverse_each do |val|
        raise ArgumentError unless val.between?(0, base - 1)
        result += val * exponent
        exponent *= base
      end
      result
    end

    def recompose(number, base)
      converted = []
      while number.positive?
        converted << number % base
        number /= base
      end
      converted << 0 if converted.empty?
      converted.reverse!
    end
  end
end
