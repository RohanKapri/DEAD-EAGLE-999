class DndCharacter
  property name : String
  property strength : Int32
  property dexterity : Int32
  property constitution : Int32
  property intelligence : Int32
  property wisdom : Int32
  property charisma : Int32
  property hitpoints : Int32

  def initialize(name : String = "Blandalf the Beige")
    @name = name
    @strength = self.class.ability
    @dexterity = self.class.ability
    @constitution = self.class.ability
    @intelligence = self.class.ability
    @wisdom = self.class.ability
    @charisma = self.class.ability
    @hitpoints = 10 + self.class.modifier(@constitution)
  end

  def self.modifier(score)
    (score - 10) // 2
  end

  def self.ability
    [rand(1..6), rand(1..6), rand(1..6), rand(1..6)].sort![0..2].sum
  end
end