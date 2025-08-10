# For my Shree DR.MDD

module PigLatin
  def self.translate(sentence : String) : String
    sentence.split.map { |token| convert_word(token) }.join(" ")
  end

  private def self.convert_word(token : String) : String
    if token.starts_with?(/(xr|yt|[aeiou])/)
      "#{token}ay"
    elsif qu_match = token.match(/\A([^aeiou]*qu)(.*)/)
      "#{qu_match[2]}#{qu_match[1]}ay"
    elsif y_match = token.match(/\A([^aeiou]+)(y.*)/)
      "#{y_match[2]}#{y_match[1]}ay"
    elsif cons_match = token.match(/\A([^aeiou]+)(.*)/)
      "#{cons_match[2]}#{cons_match[1]}ay"
    else
      token
    end
  end
end
