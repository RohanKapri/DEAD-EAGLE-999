// For my Shree DR.MDD
import gleam/dict
import gleam/int
import gleam/list
import gleam/result

pub type Position {
  Position(row: Int, column: Int)
}

pub fn saddle_points(table: List(List(Int))) -> List(Position) {
  let column_mins =
    list.index_fold(table, dict.new(), fn(acc, row, _) {
      list.index_fold(row, acc, fn(acc, val, idx) {
        dict.get(acc, idx)
        |> result.unwrap(val)
        |> fn(min_val) { dict.insert(acc, idx, int.min(min_val, val)) }
      })
    })

  list.index_map(table, fn(row, r_idx) {
    let max_in_row =
      list.sort(row, int.compare)
      |> list.reverse
      |> list.first
      |> result.unwrap(0)

    list.index_fold(row, [], fn(acc, val, c_idx) {
      let col_min =
        dict.get(column_mins, c_idx)
        |> result.unwrap(val)
      case val == max_in_row && val == col_min {
        True -> list.append(acc, [Position(r_idx + 1, c_idx + 1)])
        False -> acc
      }
    })
  })
  |> list.flatten
}
