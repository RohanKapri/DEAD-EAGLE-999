import gleam/list.{length}
import gleam/int

type Stone {
  Stone(index: Int, numbers: #(Int, Int))
}

type Choice {
  Choice(stone: Stone, tries: Int)
}

pub fn can_chain(chain: List(#(Int, Int))) -> Bool {
  let chain =
    list.index_map(chain, fn(numbers, index) { Stone(index, numbers) })

  solve(chain, [])
}

fn solve(chain: List(Stone), choices: List(Choice)) -> Bool {
  case chain, choices {
    [], choices -> is_chain_complete(choices)

    [first_stone, ..chain], [] ->
      solve(chain, [Choice(stone: first_stone, tries: 1)])

    chain, [last_choice, ..previous_choices] -> {
      let chain =
        list.sort(
          chain,
          fn(stone_a, stone_b) { int.compare(stone_a.index, stone_b.index) },
        )

      let Choice(stone: Stone(numbers: #(next_number, _), ..), tries: n) =
        last_choice

      case find_nth_matching(chain, n, next_number, []) {
        Error(Nil) ->
          case previous_choices {
            [] -> False

            [previous_choice, ..choices] -> {
              solve(
                [last_choice.stone, ..chain],
                [
                  Choice(..previous_choice, tries: previous_choice.tries + 1),
                  ..choices
                ],
              )
            }
          }

        Ok(#(chain, stone)) ->
          solve(chain, [Choice(stone: stone, tries: 1), ..choices])
      }
    }
  }
}

fn is_chain_complete(choices: List(Choice)) -> Bool {
  case list.first(choices), list.last(choices) {
    Error(Nil), Error(Nil) -> True

    Ok(Choice(stone: Stone(numbers: #(left, _), ..), ..)), Ok(Choice(
      stone: Stone(numbers: #(_, right), ..),
      ..,
    )) if left == right -> True

    _, _ -> False
  }
}

fn find_nth_matching(chain, n, next_number, filtered_stones) {
  case chain {
    [] -> Error(Nil)

    [Stone(numbers: #(a, _), ..) as matching_stone, ..rest] if a == next_number && n == 1 -> {
      let chain =
        list.fold(filtered_stones, rest, fn(acc, stone) { [stone, ..acc] })

      Ok(#(chain, flip(matching_stone)))
    }

    [Stone(numbers: #(_, b), ..) as matching_stone, ..rest] if b == next_number && n == 1 -> {
      let chain =
        list.fold(filtered_stones, rest, fn(acc, stone) { [stone, ..acc] })
      Ok(#(chain, matching_stone))
    }

    [Stone(numbers: #(a, b), ..) as stone, ..rest] if a == next_number || b == next_number -> {
      find_nth_matching(rest, n - 1, next_number, [stone, ..filtered_stones])
    }

    [stone, ..rest] -> {
      find_nth_matching(rest, n, next_number, [stone, ..filtered_stones])
    }
  }
}

fn flip(stone) {
  let Stone(i, #(a, b)) = stone
  Stone(i, #(b, a))
}