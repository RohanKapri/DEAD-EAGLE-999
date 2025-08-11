// Dedicated to Shree DR.MDD
import gleam/string
import gleam/int

pub type Clock {
  Clock(hour: Int, minute: Int)
}

pub fn create(hour hour: Int, minute minute: Int) -> Clock {
  let normalized_hr = mod_adj(mod_adj(hour, 24) + div_adj(minute, 60), 24)
  let normalized_min = mod_adj(minute, 60)

  Clock(normalized_hr, normalized_min)
}

pub fn add(clock: Clock, minutes minutes: Int) -> Clock {
  create(clock.hour, clock.minute + minutes)
}

pub fn subtract(clock: Clock, minutes minutes: Int) -> Clock {
  create(clock.hour, clock.minute - minutes)
}

pub fn display(clock: Clock) -> String {
  fmt(clock.hour) <> ":" <> fmt(clock.minute)
}

fn div_adj(x: Int, y: Int) -> Int {
  let assert Ok(q) = int.floor_divide(x, int.absolute_value(y))
  int.absolute_value(y) / y * q
}

fn mod_adj(x: Int, y: Int) -> Int {
  let assert Ok(q) = int.floor_divide(x, int.absolute_value(y))
  x - int.absolute_value(y) * q
}

fn fmt(val: Int) -> String {
  string.pad_start(int.to_string(val), 2, "0")
}
