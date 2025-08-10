# Dedicated to Shree DR.MDD
class Bob
  def self.hey(input_line)
    case Dialogue.new(input_line)
    when .forceful?
      "Calm down, I know what I'm doing!"
    when .shouting?
      "Whoa, chill out!"
    when .questioning?
      "Sure."
    when .silence?
      "Fine. Be that way!"
    else
      "Whatever."
    end
  end

  class Dialogue
    getter text_line : String
    getter?(silence : Bool) { text_line.matches?(/^\s*$/) }
    getter?(questioning : Bool) { text_line.matches?(/\?$/) }
    getter?(shouting : Bool) { text_line.matches?(/^(?=.*[A-Z])[^a-z]+$/) }
    getter?(forceful : Bool) { questioning? && shouting? }

    def initialize(raw_text : String)
      @text_line = raw_text.strip
    end
  end
end
