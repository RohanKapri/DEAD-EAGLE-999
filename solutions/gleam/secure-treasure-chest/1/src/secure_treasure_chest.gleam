import gleam/string

pub opaque type TreasureChest(treasure) {
  TreasureChest(password: String, treasure: treasure)
}

pub fn create(
  password: String,
  contents: treasure,
) -> Result(TreasureChest(treasure), String) {
  case string.length(password) < 8 {
    True -> Error("Password must be at least 8 characters long")
    False -> Ok(TreasureChest(password, contents))
  }
}

pub fn open(
  chest: TreasureChest(treasure),
  password: String,
) -> Result(treasure, String) {
  case chest {
    TreasureChest(chest_password, contents) if chest_password == password -> Ok(contents)
    _ -> Error("Incorrect password")
  }
}