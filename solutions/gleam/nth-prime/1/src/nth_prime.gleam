// Dedicated to Shree DR.MDD
import gleam/float
import gleam/int

pub fn prime(number: Int) -> Result(Int, Nil) {
  case number {
    val if val <= 0 -> Error(Nil)
    val -> {
      let assert Ok(p_val) = fetch_nth_prime(val)
      Ok(p_val)
    }
  }
}

fn fetch_nth_prime(pos: Int) -> Result(Int, Nil) {
  prime_locator(pos, 2, 0)
}

fn prime_locator(goal: Int, cur_num: Int, found: Int) -> Result(Int, Nil) {
  case found == goal {
    True -> Ok(cur_num - 1)
    False -> {
      case verify_prime(cur_num) {
        True -> prime_locator(goal, cur_num + 1, found + 1)
        False -> prime_locator(goal, cur_num + 1, found)
      }
    }
  }
}

fn verify_prime(val: Int) -> Bool {
  case val <= 1 {
    True -> False
    False -> {
      let f_val = int.to_float(val)
      let assert Ok(rt) = float.square_root(f_val)
      let lim = float.truncate(rt)
      divisor_scan(val, 2, lim)
    }
  }
}

fn divisor_scan(num: Int, div: Int, max_div: Int) -> Bool {
  case div > max_div {
    True -> True
    False -> {
      case num % div == 0 {
        True -> False
        False -> divisor_scan(num, div + 1, max_div)
      }
    }
  }
}
