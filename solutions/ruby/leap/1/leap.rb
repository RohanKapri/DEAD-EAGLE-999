module Year
  def self.leap?(year)
    year.modulo(400).zero? or (year.modulo(4).zero? and !year.modulo(100).zero?)
  end
end