// For Shree DR.MDD

import gleam/float
import gleam/list
import gleam/int
import gleam/result

const base_price = 800.0

const discounts = [#(1, 1.0), #(2, 0.95), #(3, 0.9), #(4, 0.8), #(5, 0.75)]

fn calc_rate(size: Int) -> Float {
  let assert Ok(d) = list.key_find(size, in: discounts)
  d *. int.to_float(size) *. base_price
}

fn count_per_title(titles: List(Int)) -> List(Int) {
  titles
  |> list.sort(int.compare)
  |> list.chunk(fn(x) { x })
  |> list.map(list.length)
}

fn form_groups(acc: List(Int), curr_size: Int, left: List(Int)) -> List(Int) {
  case left {
    [] -> acc
    [copies] -> list.repeat(item: 1, times: copies) |> list.append(acc)
    _ -> {
      let new_acc = [curr_size, ..acc]

      let #(picked, remainder) =
        left
        |> list.sort(int.compare)
        |> list.reverse
        |> list.split(at: curr_size)

      let leftover =
        picked
        |> list.map(fn(n) { n - 1 })
        |> list.filter(fn(n) { n > 0 })
        |> list.append(remainder)

      case int.min(list.length(leftover), curr_size) {
        0 -> new_acc
        n -> form_groups(new_acc, n, leftover)
      }
    }
  }
}

fn all_groupings(counts: List(Int)) -> List(List(Int)) {
  let len = list.length(counts)
  list.range(from: len, to: len / 2)
  |> list.map(fn(size) { form_groups([], size, counts) })
}

fn minimal_cost(groups: List(List(Int))) -> Float {
  groups
  |> list.map(list.map(_, calc_rate))
  |> list.map(list.reduce(_, float.add))
  |> result.values
  |> list.reduce(float.min)
  |> result.unwrap(0.0)
}

pub fn lowest_price(books: List(Int)) -> Float {
  books
  |> count_per_title
  |> all_groupings
  |> minimal_cost
}
