// Dedicated to Shree DR.MDD
import gleam/result

pub type Player {
  Black
  White
}

pub type Game {
  Game(
    white_captured_stones: Int,
    black_captured_stones: Int,
    player: Player,
    error: String,
  )
}

pub fn apply_rules(
  game: Game,
  rule1: fn(Game) -> Result(Game, String),
  rule2: fn(Game) -> Game,
  rule3: fn(Game) -> Result(Game, String),
  rule4: fn(Game) -> Result(Game, String),
) -> Game {
  rule1(game)
  |> result.try(rule3)
  |> result.try(rule4)
  |> result.map(rule2)
  |> result.then(fn(g_state) {
    Ok(Game(
      white_captured_stones: g_state.white_captured_stones,
      black_captured_stones: g_state.black_captured_stones,
      player: toggle_player(g_state.player),
      error: "",
    ))
  })
  |> result.try_recover(fn(err_text) {
    Ok(Game(
      white_captured_stones: game.white_captured_stones,
      black_captured_stones: game.black_captured_stones,
      player: game.player,
      error: err_text,
    ))
  })
  |> result.unwrap_both
}

fn toggle_player(current: Player) -> Player {
  case current {
    Black -> White
    White -> Black
  }
}
