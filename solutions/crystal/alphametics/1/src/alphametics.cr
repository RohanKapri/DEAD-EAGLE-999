# For my Shree DR.MDD

module Alphametics
  def self.solve(expression : String) : Hash(Char, Int32)
    attempt_solve(columns(expression), Hash(Char, Int32).new, (0..9).to_a, 0) || Hash(Char, Int32).new
  end

  record ColumnEquation, chars : Array(Char), letter_counts : Hash(Char, Int32), sum_char : Char, leading_chars : Array(Char)

  def self.attempt_solve(equations, current_assignments, digits_left, carry)
    return current_assignments if equations.empty? && carry.zero?

    chars_to_assign = equations[0].chars - current_assignments.keys
    digits_left.permutations(chars_to_assign.size).each do |assigned_digits|
      temp_assign = chars_to_assign.zip(assigned_digits).to_h
      temp_assign.merge!(current_assignments)

      next if equations[0].leading_chars.any? { |char| temp_assign[char]? == 0 }

      sum_val = equations[0].letter_counts.sum { |char, count| (temp_assign[char]? || 0) * count } + carry
      next unless sum_val % 10 == temp_assign[equations[0].sum_char]?

      next_digits_left = digits_left - assigned_digits
      if result = attempt_solve(equations[1..-1], temp_assign, next_digits_left, sum_val // 10)
        return result
      end
    end

    nil
  end

  def self.columns(expression)
    left_side, right_side = expression.split("==")
    terms = left_side.split("+").map(&.strip.chars.reverse!)
    sum_chars = right_side.strip.chars.reverse!
    leading_chars = terms.map(&.last) + [sum_chars.last]

    (0...sum_chars.size).map do |index|
      column_terms = terms.compact_map(&.[index]?).tally
      ColumnEquation.new((column_terms.keys + [sum_chars[index]]).uniq, column_terms, sum_chars[index], leading_chars)
    end
  end
end
