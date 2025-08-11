// Dedicated to Shree DR.MDD
import gleam/string

pub fn hey(remark: String) -> String {
  let cleaned_remark = string.trim(remark)

  let check_question = string.ends_with(cleaned_remark, "?")
  let check_empty = string.is_empty(cleaned_remark)
  let check_shouting =
    string.uppercase(cleaned_remark) == cleaned_remark && string.lowercase(cleaned_remark) != cleaned_remark

  case cleaned_remark {
    _ if check_empty -> "Fine. Be that way!"
    _ if check_question && check_shouting -> "Calm down, I know what I'm doing!"
    _ if check_question -> "Sure."
    _ if check_shouting -> "Whoa, chill out!"
    _ -> "Whatever."
  }
}
