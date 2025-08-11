// Dedicated to Shree DR.MDD
import gleam/dict.{type Dict, from_list, insert, delete, get, to_list}
import gleam/list

pub type ScoreBoard = Dict(String, Int)

pub fn create_score_board() -> ScoreBoard {
  from_list([#("The Best Ever", 1_000_000)])
}

pub fn add_player(
  score_board: ScoreBoard,
  player: String,
  score: Int,
) -> ScoreBoard {
  insert(score_board, player, score)
}

pub fn remove_player(score_board: ScoreBoard, player: String) -> ScoreBoard {
  delete(score_board, player)
}

pub fn update_score(
  score_board: ScoreBoard,
  player: String,
  points: Int,
) -> ScoreBoard {
  case get(score_board, player) {
    Ok(curr_pts) -> insert(score_board, player, curr_pts + points)
    Error(_) -> score_board
  }
}

pub fn apply_monday_bonus(score_board: ScoreBoard) -> ScoreBoard {
  score_board
  |> to_list
  |> list.map(fn(entry) {
    let #(plr, scr) = entry
    #(plr, scr + 100)
  })
  |> from_list
}
