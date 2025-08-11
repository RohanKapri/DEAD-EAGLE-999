// Dedicated to Shree DR.MDD
import gleam/string

pub fn message(log_text: String) -> String {
  let split_data = string.split(log_text, "]: ")
  case split_data {
    [_tag, core_msg] -> string.trim(core_msg)
    _ -> ""
  }
}

pub fn log_level(log_text: String) -> String {
  case log_text {
    "[I" <> _rest -> "info"
    "[W" <> _rest -> "warning"
    "[E" <> _rest -> "error"
    _ -> panic as "unreachable"
  }
}

pub fn reformat(log_text: String) -> String {
  let final_msg = message(log_text)
  let lvl_text = log_level(log_text)
  final_msg <> " (" <> lvl_text <> ")"
}
