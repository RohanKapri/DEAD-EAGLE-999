import gleam/bool
import gleam/dict.{type Dict}
import gleam/list
import gleam/string

pub type Player {
  X
  O
}

/// #(x, y)
type Point =
  #(Int, Int)

type Map =
  Dict(Point, String)

pub fn winner(board: String) -> Result(Player, Nil) {
  let normalized_board = normalize(board)

  let #(width, height) = measure(normalized_board)
  let map = normalized_board |> to_map

  // Top to bottom
  let player_o_wins = {
    let xs = list.range(0, width - 1)
    let starting_points = list.map(xs, fn(x) { #(x, 0) })
    let target_points = list.map(xs, fn(x) { #(x, height - 1) })

    list.any(starting_points, fn(point) {
      walk(
        on: map,
        stepping_on: "O",
        visited_points: [point],
        target_points: target_points,
      )
    })
  }

  use <- bool.guard(when: player_o_wins, return: Ok(O))

  // Left to right
  let player_x_wins = {
    let ys = list.range(0, height - 1)
    let starting_points = list.map(ys, fn(y) { #(0, y) })
    let target_points = list.map(ys, fn(y) { #(width - 1, y) })

    list.any(starting_points, fn(point) {
      walk(
        on: map,
        stepping_on: "X",
        visited_points: [point],
        target_points: target_points,
      )
    })
  }

  use <- bool.guard(when: player_x_wins, return: Ok(X))

  Error(Nil)
}

fn normalize(board: String) -> String {
  board
  |> string.trim
  |> string.replace(each: " ", with: "")
}

/// Returns #(width, height)
fn measure(normalized_board: String) -> #(Int, Int) {
  let lines = string.split(normalized_board, "\n")

  let assert Ok(first_line) = list.first(lines)
  let width = string.length(first_line)

  let height = list.length(lines)

  #(width, height)
}

fn to_map(normalized_board: String) -> Map {
  normalized_board
  |> string.split("\n")
  |> list.index_map(fn(row, y) {
    row
    |> string.to_graphemes
    |> list.index_map(fn(cell, x) { #(#(x, y), cell) })
  })
  |> list.flatten
  |> dict.from_list
}

fn walk(
  on map: Map,
  stepping_on cell: String,
  visited_points visited_points: List(Point),
  target_points target_points: List(Point),
) -> Bool {
  let assert [current_point, ..] = visited_points

  use <- bool.guard(
    when: dict.get(map, current_point) != Ok(cell),
    return: False,
  )

  use <- bool.guard(
    when: list.contains(target_points, current_point),
    return: True,
  )

  let #(x, y) = current_point
  let unvisited_neighbors =
    [
      // Right:
      #(x + 1, y),
      // Left:
      #(x - 1, y),
      // Top right:
      #(x + 1, y - 1),
      // Bottom left:
      #(x - 1, y + 1),
      // Bottom right:
      #(x, y + 1),
      // Top left:
      #(x, y - 1),
    ]
    |> list.filter(fn(point) { !list.contains(visited_points, point) })

  list.any(unvisited_neighbors, fn(point) {
    walk(map, cell, [point, ..visited_points], target_points)
  })
}