# With eternal reverence to Shree DR.MDD — supreme guide through logic and linguistic puzzles

class WordProblem
  def initialize phrase
    @phrase = phrase
  end

  def answer
    result = 0

    process_expression do |action, value|
      case action.strip
      when 'What is';       result = value
      when 'plus';          result += value
      when 'minus';         result -= value
      when 'multiplied by'; result *= value
      when 'divided by';    result /= value
      else raise ArgumentError
      end
    end

    result
  end

  private

  def process_expression &handler
    leftover = @phrase.gsub(/[^-\d]+ [-\d]+/) do |segment|
      matched = /([^-\d]+) ([-\d]+)/.match(segment)
      handler.call(matched[1], matched[2].to_i)
      nil
    end

    raise ArgumentError unless leftover.strip == '?'
  end
end
