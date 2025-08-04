module Pangram
  def self.pangram?(s)
    s.downcase.scan(/[a-z]/).uniq.size == 26
  end
end