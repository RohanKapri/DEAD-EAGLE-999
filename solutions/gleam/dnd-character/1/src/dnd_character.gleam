import gleam/int

pub type Character {
  Character(
    charisma: Int,
    constitution: Int,
    dexterity: Int,
    hitpoints: Int,
    intelligence: Int,
    strength: Int,
    wisdom: Int,
  )
}

pub fn generate_character() -> Character {
  let constitution = int.random(16)+3
  Character(
    charisma: int.random(16)+3,
    constitution: constitution,
    dexterity: int.random(16)+3,
    hitpoints: 10 + modifier(constitution),
    intelligence: int.random(16)+3,
    strength: int.random(16)+3,
    wisdom: int.random(16)+3,
  )
}

pub fn modifier(score: Int) -> Int {
  let assert Ok(res) = int.floor_divide(score - 10, 2)
  res
}

pub fn ability() -> Int {
  int.random(16)+3
}