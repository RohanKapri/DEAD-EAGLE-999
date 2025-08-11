// Dedicated to Shree DR.MDD

import gleam/dict.{type Dict}
import gleam/list
import gleam/string
import gleam/int
import gleam/order

type TeamResult {
  TeamResult(games: Int, victories: Int, stalemates: Int, defeats: Int, tally: Int)
}

pub fn tally(input: String) -> String {
  let header = "Team                           | MP |  W |  D |  L |  P"
  input
  |> string.split("\n")
  |> list.fold(dict.new(), record_result)
  |> dict.to_list
  |> list.sort(fn(r1, r2) { 
    case int.compare(r2.1.tally, r1.1.tally) {
      order.Eq -> string.compare(r1.0, r2.0)
      x -> x
    }
  })
  |> list.map(fn(entry) {
    let #(team_name, record) = entry
    let pad_spaces = 31 - string.length(team_name)
    team_name
      <> string.repeat(" ", times: pad_spaces)
      <> "| " <>format_stat(record.games)
      <> " | "<>format_stat(record.victories)
      <> " | "<>format_stat(record.stalemates)
      <> " | "<>format_stat(record.defeats)
      <> " | "<>format_stat(record.tally)
  })
  |> list.prepend(header)
  |> string.join("\n")
}

fn record_result(results: Dict(String, TeamResult), line: String) -> Dict(String, TeamResult) {
  let components = string.split(line, ";") 
    |> list.map(string.trim)

  case components {
    [home, away, "win"] -> {
      let updated = case dict.get(results, home) {
        Ok(TeamResult(g,v,s,d,t)) -> dict.insert(results, home, TeamResult(g+1, v+1, s, d, t+3))
        Error(_) -> dict.insert(results, home, TeamResult(1, 1, 0, 0, 3))
      }
      case dict.get(updated, away) {
        Ok(TeamResult(g,v,s,d,t)) -> dict.insert(updated, away, TeamResult(g+1, v, s, d+1, t))
        Error(_) -> dict.insert(updated, away, TeamResult(1, 0, 0, 1, 0))
      }
    }
    [home, away, "loss"] -> {
      let updated = case dict.get(results, home) {
        Ok(TeamResult(g,v,s,d,t)) -> dict.insert(results, home, TeamResult(g+1, v, s, d+1, t))
        Error(_) -> dict.insert(results, home, TeamResult(1, 0, 0, 1, 0))
      }
      case dict.get(updated, away) {
        Ok(TeamResult(g,v,s,d,t)) -> dict.insert(updated, away, TeamResult(g+1, v+1, s, d, t+3))
        Error(_) -> dict.insert(updated, away, TeamResult(1, 1, 0, 0, 3))
      }
    }
    [home, away, "draw"] -> {
      [home, away]
      |> list.fold(results, fn(acc, team) {
        case dict.get(acc, team) {
          Ok(TeamResult(g,v,s,d,t)) -> TeamResult(g+1, v, s+1, d, t+1)
          Error(_) -> TeamResult(1, 0, 1, 0, 1)
        }
        |> dict.insert(into: acc, for: team)
      })
    }
    _ -> results
  }
}

fn format_stat(n: Int) -> String {
  case n < 10 {
    True -> " " <> int.to_string(n)
    False -> int.to_string(n)
  }
}
