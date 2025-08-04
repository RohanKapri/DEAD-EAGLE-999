class DndCharacter
  def self.modifier(score)
    (score - 10) / 2
  end

  attr_accessor \
    :strength,
    :dexterity,
    :constitution,
    :intelligence,
    :wisdom,
    :charisma,
    :hitpoints

  def initialize
    @strength = ability
    @dexterity = ability
    @constitution = ability
    @intelligence = ability
    @wisdom = ability
    @charisma = ability
    @hitpoints = 10 + self.class.modifier(@constitution)
  end

  private

  def ability
    [rand(1..6), rand(1..6), rand(1..6), rand(1..6)].sort.take(3).sum
  end
end