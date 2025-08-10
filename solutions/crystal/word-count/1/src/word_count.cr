require "string_scanner"

module WordCount
  alias Map = Hash(String, Int32)
  RWORD = /\w+('\w+)?/

  def self.count_words(sentence : String) : Map
    counts = Map.new(0)
    sentence.downcase.scan(RWORD) do |word_match|
      word = word_match[0] # Extracting the string from MatchData
      counts[word] += 1
    end
    counts
  end
end