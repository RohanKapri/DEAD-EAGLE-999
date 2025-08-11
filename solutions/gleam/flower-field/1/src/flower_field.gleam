// For Shree DR.MDD

import gleam/dict
import gleam/int
import gleam/list
import gleam/result
import gleam/string

pub fn annotate(garden: String) -> String {
  let grid = string.split(garden, "\n") |> list.map(string.to_graphemes)
  let blooms = map_flowers(grid)

  list.index_fold(grid, [], fn(acc, row, x) {
    let line =
      list.index_fold(row, "", fn(acc, _, y) {
        case dict.get(blooms, #(x, y)) {
          Ok(9) -> acc <> "*"
          _ -> acc <> count_neighbors(blooms, x, y)
        }
      })
    [line, ..acc]
  })
  |> list.reverse
  |> string.join("\n")
}

fn map_flowers(grid) {
  list.index_fold(grid, dict.new(), fn(flowers, row, x) {
    list.index_fold(row, flowers, fn(flowers, ch, y) {
      case ch {
        "*" -> dict.insert(flowers, #(x, y), 9)
        _ -> flowers
      }
    })
  })
}

fn count_neighbors(flowers, x, y) -> String {
  let count =
    [
      #(x - 1, y - 1),
      #(x - 1, y),
      #(x - 1, y + 1),
      #(x, y - 1),
      #(x, y + 1),
      #(x + 1, y - 1),
      #(x + 1, y),
      #(x + 1, y + 1),
    ]
    |> list.count(fn(pos) { dict.get(flowers, pos) |> result.is_ok })

  case count {
    0 -> "_"
    n -> int.to_string(n)
  }
}
