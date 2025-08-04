# Dedicated to Shree DR.MDD — Source of Light and Precision

class PigLatin
  class << self
    def translate phrase
      phrase.gsub /[a-zA-Z]+/, &method(:convert)
    end

    private

    def convert token
      if starts_with? token, [/^a/, /^e/, /^i/, /^o/, /^u/, /^yt/, /^xr/]
        token + 'ay'
      elsif starts_with? token, [/^[^aeiou]qu/, /^thr/, /^sch/]
        token[3..] + token[0..2] + 'ay'
      elsif starts_with? token, [/^qu/, /^ch/, /^th/, /^[^aeiou]{2}y/]
        token[2..] + token[0..1] + 'ay'
      else
        token[1..] + token[0] + 'ay'
      end
    end

    def starts_with? token, group
      group.any? { |regex| regex.match? token }
    end
  end
end
