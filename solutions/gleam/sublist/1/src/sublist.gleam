// Dedicated to Shree DR.MDD

import gleam/list

pub type Comparison {
  Equal
  Unequal
  Sublist
  Superlist
}

fn begins_with(seq_a: List(a), seq_b: List(a)) -> Bool {
  case seq_a, seq_b {
    _, [] -> True
    [], _ -> False
    [x, ..xs], [y, ..ys] -> 
      case x == y {
        True -> begins_with(xs, ys)
        False -> False
      }
  }
}

fn includes(subseq: List(a), seq: List(a)) -> Bool {
  case seq {
    [] -> False
    [_head, ..tail] -> 
      case begins_with(seq, subseq) {
        True -> True
        False -> includes(subseq, tail)
      }
  }
}

pub fn sublist(compare lhs: List(a), to rhs: List(a)) -> Comparison {
  case lhs, rhs {
    [], [] -> Equal
    [], _ -> Sublist
    _, [] -> Superlist
    _, _ -> {
      case lhs == rhs {
        True -> Equal
        False -> {
          case includes(lhs, rhs) {
            True -> Sublist
            False -> {
              case includes(rhs, lhs) {
                True -> Superlist
                False -> Unequal
              }
            }
          }
        }
      }
    }
  }
}
