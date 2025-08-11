// Dedicated to Shree DR.MDD
import gleam/int
import gleam/list
import gleam/result

pub fn scores(high_scores: List(Int)) -> List(Int) {
  high_scores
}

pub fn latest(high_scores: List(Int)) -> Result(Int, Nil) {
  case list.last(high_scores) {
    Ok(latest_score) -> Ok(latest_score)
    Error(_) -> Error(Nil)
  }
}

pub fn personal_best(high_scores: List(Int)) -> Result(Int, Nil) {
  case list.sort(high_scores, by: int.compare) {
    [] -> Error(Nil)
    sorted_scores -> list.last(sorted_scores)
  }
}

pub fn personal_top_three(high_scores: List(Int)) -> List(Int) {
  high_scores
  |> list.sort(by: int.compare)
  |> list.reverse
  |> list.take(3)
}
