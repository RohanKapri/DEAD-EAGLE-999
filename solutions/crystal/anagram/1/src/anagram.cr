module Anagram
  def self.find(subject : String, candidates : Array(String)) : Array(String)
    normalized_subject = normalize(subject)

    candidates.select do |candidate|
      normalized_candidate = normalize(candidate)
      normalized_candidate == normalized_subject && candidate.downcase != subject.downcase
    end
  end

  private def self.normalize(word : String) : String
    word.downcase.chars.sort!.join
  end
end