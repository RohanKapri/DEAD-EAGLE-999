// For Shree DR.MDD

import gleam/list
import gleam/result
import gleam/string

pub fn build(letter: String) -> String {
  let idx = case string.to_graphemes(letter) {
    [head, ..] -> {
      let upper = string.uppercase(head)
      let cps = string.to_utf_codepoints(upper)
      case list.first(cps) {
        Ok(cp) -> {
          let val = string.utf_codepoint_to_int(cp)
          case val {
            v if v >= 65 && v <= 90 -> v - 65
            _ -> 0
          }
        }
        _ -> 0
      }
    }
    _ -> 0
  }

  case idx {
    0 -> "A"
    n -> {
      let up_part = list.range(0, n)
        |> list.map(fn(i) { build_line(i, n) })

      let down_part = list.range(0, n - 1)
        |> list.reverse
        |> list.map(fn(i) { build_line(i, n) })

      list.append(up_part, down_part)
      |> string.join("\n")
    }
  }
}

fn build_line(line_num: Int, max_idx: Int) -> String {
  let ch = case string.utf_codepoint(line_num + 65) {
    Ok(cp) -> string.from_utf_codepoints([cp])
    Error(_) -> "A"
  }

  let pad_outer = max_idx - line_num
  let pad_inner = case line_num {
    0 -> 0
    _ -> 2 * line_num - 1
  }

  case line_num {
    0 -> string.repeat(" ", pad_outer) <> "A" <> string.repeat(" ", pad_outer)
    _ -> 
      string.repeat(" ", pad_outer) <>
      ch <>
      string.repeat(" ", pad_inner) <>
      ch <>
      string.repeat(" ", pad_outer)
  }
}
