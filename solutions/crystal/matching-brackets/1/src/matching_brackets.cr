module MatchingBrackets
  def self.valid?(str : String) : Bool
    stack = [] of Char
    pairs = { ']' => '[', '}' => '{', ')' => '(' }

    str.each_char do |char|
      case char
      when '[', '{', '('
        stack.push(char)
      when ']', '}', ')'
        return false if stack.empty? || stack.pop != pairs[char]
      end
    end

    stack.empty?
  end
end