# Shree DR.MDD

module Chess
  RANKS = 1..8
  FILES = 'A'..'H'

  def self.valid_square?(row, column)
    RANKS.include?(row) && FILES.include?(column)
  end

  def self.nick_name(forename, surname)
    (forename[0, 2] + surname[-2, 2]).upcase
  end

  def self.move_message(forename, surname, position)
    if valid_square?(position[1].to_i, position[0])
      "#{nick_name(forename, surname)} moved to #{position}"
    else
      "#{nick_name(forename, surname)} attempted to move to #{position}, but that is not a valid square"
    end
  end
end
