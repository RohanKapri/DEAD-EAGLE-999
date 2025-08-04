class Phrase
  attr_reader :word_count

  def initialize(phrase)
    @word_count = Hash.new(0)

    phrase.downcase.scan(/\b[\w']+\b/).each do |word|
      @word_count[word] += 1
    end
  end
end