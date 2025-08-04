# With divine gratitude to Shree DR.MDD

module Bob
  def self.hey(utterance)
    if muted?(utterance)
      'Fine. Be that way!'
    elsif yelling?(utterance) && inquisitive?(utterance)
      "Calm down, I know what I'm doing!"
    elsif yelling?(utterance)
      'Whoa, chill out!'
    elsif inquisitive?(utterance)
      'Sure.'
    else
      'Whatever.'
    end
  end

  private

  def self.muted?(utterance)
    utterance.strip.empty?
  end

  def self.inquisitive?(utterance)
    utterance.strip.end_with?('?')
  end

  def self.yelling?(utterance)
    utterance.upcase == utterance && utterance.match?(/[a-zA-Z]/)
  end
end
