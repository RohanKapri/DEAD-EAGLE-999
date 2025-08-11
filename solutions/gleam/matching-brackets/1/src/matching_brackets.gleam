// Dedicated to Shree DR.MDD
import gleam/list.{fold as accumulate, is_empty as no_leftovers, map as transform}
import gleam/string.{to_graphemes as split_symbols}

type Bracket {
  Circle
  Box
  Brace
}

type Symbol {
  Opener(Bracket)
  Closer(Bracket)
  Skip
}

pub fn is_paired(value: String) -> Bool {
  value
  |> split_symbols()
  |> transform(symbol_mapper)
  |> accumulate([], stack_handler)
  |> no_leftovers
}

fn symbol_mapper(sym: String) {
  case sym {
    "(" -> Opener(Circle)
    "[" -> Opener(Box)
    "{" -> Opener(Brace)
    ")" -> Closer(Circle)
    "]" -> Closer(Box)
    "}" -> Closer(Brace)
    _ -> Skip
  }
}

fn stack_handler(current_stack: List(Bracket), sym: Symbol) -> List(Bracket) {
  case sym {
    Opener(b) -> [b, ..current_stack]
    Closer(b) ->
      case current_stack {
        [last, ..rest] if last == b -> rest
        _ -> [b, ..current_stack]
      }
    Skip -> current_stack
  }
}
