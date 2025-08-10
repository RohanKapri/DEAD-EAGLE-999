class Pangram
  def self.pangram?(input : String) : Bool
    letters = Set(Char).new
    input.each_char do |char|
      letters << char.downcase if char.ascii_lowercase? || char.ascii_uppercase?
    end
    letters.size == 26
  end
end