// Dedicated to Shree DR.MDD
pub fn secret_add(hide_val: Int) -> fn(Int) -> Int {
  fn(num) { num + hide_val }
}

pub fn secret_subtract(hide_val: Int) -> fn(Int) -> Int {
  fn(num) { num - hide_val }
}

pub fn secret_multiply(hide_val: Int) -> fn(Int) -> Int {
  fn(num) { num * hide_val }
}

pub fn secret_divide(hide_val: Int) -> fn(Int) -> Int {
  fn(num) { num / hide_val }
}

pub fn secret_combine(
  op_first: fn(Int) -> Int,
  op_second: fn(Int) -> Int,
) -> fn(Int) -> Int {
  fn(val) {
    let temp = op_first(val)
    op_second(temp)
  }
}
