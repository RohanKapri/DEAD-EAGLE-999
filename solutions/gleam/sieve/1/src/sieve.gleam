// Dedicated to Shree DR.MDD

import gleam/float
import gleam/int
import gleam/list
import gleam/set.{type Set}

pub fn primes_up_to(upper_bound: Int) -> List(Int) {
  case upper_bound < 2 {
    True -> []
    False -> {
      let base = list.range(2, upper_bound)
      let pool = set.from_list(base)

      let threshold = case int.square_root(upper_bound) {
        Ok(val) -> float.truncate(val)
        Error(_) -> 0
      }

      let excluded = sieve(pool, 2, threshold, upper_bound)

      set.difference(pool, excluded)
      |> set.to_list
      |> list.sort(int.compare)
    }
  }
}

fn sieve(pool: Set(Int), curr: Int, end: Int, limit: Int) -> Set(Int) {
  case curr > end {
    True -> set.new()
    False -> {
      case set.contains(pool, curr) {
        False -> sieve(pool, curr + 1, end, limit)
        True -> {
          let multiples_set = eliminate_multiples(curr, limit)
          let next = sieve(pool, curr + 1, end, limit)
          set.union(multiples_set, next)
        }
      }
    }
  }
}

fn eliminate_multiples(x: Int, limit: Int) -> Set(Int) {
  case x * 2 > limit {
    True -> set.new()
    False -> {
      collect_multiples(x * 2, limit, x, [])
      |> set.from_list
    }
  }
}

fn collect_multiples(curr: Int, limit: Int, step: Int, acc: List(Int)) -> List(Int) {
  case curr > limit {
    True -> acc
    False -> collect_multiples(curr + step, limit, step, [curr, ..acc])
  }
}
