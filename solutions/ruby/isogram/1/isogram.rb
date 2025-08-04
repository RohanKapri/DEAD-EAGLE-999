module Isogram
  def self.isogram?(s)
    letters = s.downcase.gsub(/[^a-z]/, '').chars.to_a
    letters.length == letters.uniq.length
  end
end