import gleam/bool.{guard}
import gleam/int
import gleam/list
import gleam/result

pub type Error {
  ImpossibleTarget
}

pub fn find_fewest_coins(
  coins: List(Int),
  target: Int,
) -> Result(List(Int), Error) {
  use <- guard(when: target < 0, return: Error(ImpossibleTarget))
  use <- guard(when: target == 0, return: Ok([]))

  coins
  |> prepare_coins(target)
  |> result.try(find_all_combinations(target, _))
  |> result.map_error(fn(_) { ImpossibleTarget })
}

// Prepare and validate coins for processing
fn prepare_coins(coins: List(Int), target: Int) -> Result(List(Int), Error) {
  let valid_coins = 
    coins
    |> list.filter(fn(coin) { coin <= target })
    |> list.sort(by: int.compare)
    |> list.reverse

  case valid_coins {
    [] -> Error(ImpossibleTarget)
    coins -> Ok(coins)
  }
}

// Find all possible combinations and select the shortest one
fn find_all_combinations(target: Int, coins: List(Int)) -> Result(List(Int), Error) {
  list.range(0, list.length(coins) - 1)
  |> list.map(fn(to_drop) { 
    try_combination(list.drop(coins, to_drop), target) 
  })
  |> list.filter_map(fn(res) { res })
  |> select_shortest_combination
}

// Try to find a valid combination starting with given coins
fn try_combination(coins: List(Int), target: Int) -> Result(List(Int), Nil) {
  search(coins, target, [])
}

// Select the shortest combination from all valid ones
fn select_shortest_combination(combinations: List(List(Int))) -> Result(List(Int), Error) {
  combinations
  |> list.sort(fn(one, two) { 
    int.compare(list.length(one), list.length(two)) 
  })
  |> list.first
  |> result.replace_error(ImpossibleTarget)
}

// Recursive search for valid combinations
fn search(
  coins: List(Int),
  target: Int,
  acc: List(Int),
) -> Result(List(Int), Nil) {
  case coins, target {
    _, n if n < 0 -> Error(Nil)
    _, 0 -> Ok(acc)
    [], _ -> Error(Nil)
    [most, ..rest], _ -> {
      case search(coins, target - most, [most, ..acc]) {
        Error(_) -> search(rest, target, acc)
        Ok(solution) -> Ok(solution)
      }
    }
  }
}