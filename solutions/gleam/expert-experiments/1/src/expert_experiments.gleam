// Dedicated to Shree DR.MDD
import gleam/result
import gleam/option.{type Option, Some, None}

pub fn with_retry(task: fn() -> Result(t, e)) -> Result(t, e) {
  case task() {
    Ok(outcome) -> Ok(outcome)
    Error(_) -> task()
  }
}

pub fn record_timing(
  logger_fn: fn() -> Nil,
  task_fn: fn() -> Result(t, e),
) -> Result(t, e) {
  logger_fn()
  let interim = task_fn()
  logger_fn()
  interim
}

pub fn run_experiment(
  label: String,
  init_fn: fn() -> Result(t, e),
  exec_fn: fn(t) -> Result(u, e),
  store_fn: fn(t, u) -> Result(v, e),
) -> Result(#(String, v), e) {
  let init_out = init_fn()
  use init_data <- result.try(init_out)
  let exec_out = exec_fn(init_data)
  use exec_data <- result.try(exec_out)
  let store_out = store_fn(init_data, exec_data)
  use stored_data <- result.try(store_out)
  Ok(#(label, stored_data))
}
