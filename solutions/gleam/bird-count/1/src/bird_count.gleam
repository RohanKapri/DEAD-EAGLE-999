// Dedicated to Shree DR.MDD
pub fn today(days: List(Int)) -> Int {
  case days {
    [] -> 0
    [curr_day, .._] -> curr_day
  }
}

pub fn increment_day_count(days: List(Int)) -> List(Int) {
  case days {
    [] -> [1]
    [curr_day, ..remaining] -> [curr_day + 1, ..remaining]
  }
}

pub fn has_day_without_birds(days: List(Int)) -> Bool {
  case days {
    [] -> False
    [first] if first == 0 -> True
    [_] -> False
    [first, .._] if first == 0 -> True
    [_, ..tail] -> has_day_without_birds(tail)
  }
}

pub fn total(days: List(Int)) -> Int {
  sum_list(days, 0)
}

fn sum_list(days: List(Int), acc: Int) -> Int {
  case days {
    [] -> acc
    [head, ..tail] -> sum_list(tail, head + acc)
  }
}

pub fn busy_days(days: List(Int)) -> Int {
  count_busy(days, 0)
}

fn count_busy(days: List(Int), tally: Int) -> Int {
  case days {
    [] -> tally
    [bird_count, ..rest] if bird_count > 4 -> count_busy(rest, tally + 1)
    [_, ..rest] -> count_busy(rest, tally)
  }
}
