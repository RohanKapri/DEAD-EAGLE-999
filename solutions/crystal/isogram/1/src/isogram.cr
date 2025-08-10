module Isogram
  def self.isogram?(phrase : String) : Bool
    seen_chars = Set(Char).new
    phrase.downcase.each_char do |char|
      next if char == '-' || char == ' '  # skip spaces and hyphens
      return false if seen_chars.includes?(char)
      seen_chars.add(char)
    end
    true
  end
end