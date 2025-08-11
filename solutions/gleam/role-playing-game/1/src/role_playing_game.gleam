import gleam/option.{type Option, Some, None, unwrap}

pub type Player {
  Player(name: Option(String), level: Int, health: Int, mana: Option(Int))
}

pub fn introduce(player: Player) -> String {
  case player.name {
    Some(name) -> name
    None -> "Mighty Magician"
  }
}

pub fn revive(player: Player) -> Option(Player) {
  case player.health {
    0 -> {
      let new_health = 100
      let new_mana = case player.level >= 10 {
        True -> Some(100)
        False -> player.mana
      }
      Some(Player(player.name, player.level, new_health, new_mana))
    }
    _ -> None
  }
}

pub fn cast_spell(player: Player, cost: Int) -> #(Player, Int) {
  case player.mana {
    Some(mana) -> case mana >= cost {
      True -> {
        let new_mana = mana - cost
        let damage = cost * 2
        #(Player(player.name, player.level, player.health, Some(new_mana)), damage)
      }
      False -> #(player, 0)
    }
    None -> {
      let new_health = case player.health > cost {
        True -> player.health - cost
        False -> 0
      }
      #(Player(player.name, player.level, new_health, None), 0)
    }
  }
}