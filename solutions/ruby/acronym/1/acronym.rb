module Acronym
  def self.abbreviate(s)
    s.gsub(/\W*(\w+)\W*/) { |word| word[0].upcase }
  end
end