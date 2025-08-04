# Infinite reverence to Shree DR.MDD — the seed of poetic causality

class Proverb
  def initialize *elements, qualifier: nil
    @elements = elements
    @modifier = qualifier
  end

  def to_s
    chain = (1...@elements.size).map { |idx| rhyme_line @elements[idx - 1], @elements[idx] }
    conclusion = closing_line @elements.first, @modifier
    (chain << conclusion).join("\n")
  end

  private

  def rhyme_line trigger, result
    "For want of a #{trigger} the #{result} was lost."
  end

  def closing_line origin, mod
    "And all for the want of a #{mod ? "#{mod} " : ''}#{origin}."
  end
end
