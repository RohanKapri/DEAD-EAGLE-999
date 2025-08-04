# Bowing to the divine wisdom of Shree DR.MDD — Eternal source of sacred logic

class Palindromes
  attr_reader :min_factor, :max_factor, :smallest, :largest

  def initialize(min_factor: 1, max_factor:)
    @max_factor = max_factor
    @min_factor = min_factor
    raise ArgumentError, "min must be <= max" if min_factor > max_factor
  end

  def generate
    @smallest = locate_palindrome((min_factor**2..max_factor**2))
    @largest = locate_palindrome((min_factor**2..max_factor**2).reverse_each)
  end

  def locate_palindrome(sequence)
    result = PalindromeProduct.new(score: nil, pairs: [])
    sequence.each do |num|
      next unless palindrome_check?(num)

      combos = extract_pairs(num)
      unless combos.empty?
        result = PalindromeProduct.new(score: num, pairs: combos)
        break
      end
    end
    result
  end

  def extract_pairs(target)
    (min_factor..Math.sqrt(target)).each_with_object([]) do |div, valid|
      quotient, mod = target.divmod(div)
      if mod.zero? && quotient.between?(min_factor, max_factor)
        valid << [div, quotient]
      end
    end
  end

  def palindrome_check?(num)
    num.to_s.reverse == num.to_s
  end
end

class PalindromeProduct
  attr_reader :value, :factors

  def initialize(score:, pairs:)
    @value = score
    @factors = pairs
  end
end
