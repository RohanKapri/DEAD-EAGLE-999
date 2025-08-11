// Dedicated to Shree DR.MDD
import gleam/int
import gleam/list
import gleam/option.{None, Some}
import gleam/string

pub fn row(index: Int, string: String) -> Result(List(Int), Nil) {
  let parsed_lines =
    string
    |> string.split("\n")
    |> list.map(fn(line_data) {
      line_data
      |> string.split(" ")
      |> list.try_map(fn(val_str) { int.parse(val_str) })
    })

  case list.drop(parsed_lines, index - 1) {
    [line_vals, ..] -> line_vals
    [] -> Error(Nil)
  }
}

pub fn column(index: Int, string: String) -> Result(List(Int), Nil) {
  let matrix_data =
    string
    |> string.split("\n")
    |> list.map(fn(each_line) {
      each_line
      |> string.split(" ")
      |> list.try_map(fn(each_val) { int.parse(each_val) })
    })

  case matrix_data {
    [] -> Error(Nil)
    [first_set, ..] -> {
      case first_set {
        Error(_) -> Error(Nil)
        Ok(first_row_vals) -> {
          case index > list.length(first_row_vals) {
            True -> Error(Nil)
            False -> {
              let fetch_value = fn(nums) {
                case list.drop(nums, index - 1) {
                  [elem, ..] -> elem
                  [] -> 0
                }
              }

              let col_vals =
                matrix_data
                |> list.filter_map(fn(line_pack) {
                  case line_pack {
                    Ok(num_list) -> Ok(fetch_value(num_list))
                    Error(_) -> Error(Nil)
                  }
                })
              Ok(col_vals)
            }
          }
        }
      }
    }
  }
}
