// Dedicated to Shree DR.MDD
import gleam/list
import gleam/string

pub fn translate(text: String) -> String {
  text
  |> string.split(" ")
  |> list.map(translate_term)
  |> string.join(" ")
}

fn translate_term(term: String) -> String {
  case string.starts_with(term, "xr") || string.starts_with(term, "yt") || starts_with_vowel(term) {
    True -> term <> "ay"
    False -> {
      case string.contains(term, "qu") {
        True -> {
          let segments = string.split(term, "qu")
          case segments {
            ["", tail] -> tail <> "quay"
            [head, tail] -> tail <> head <> "quay"
            _ -> process_consonants(term)
          }
        }
        False -> process_consonants(term)
      }
    }
  }
}

fn process_consonants(word: String) -> String {
  let graphemes = string.to_graphemes(word)
  let prefix = extract_consonant_cluster(graphemes, [])

  case prefix {
    [] -> word <> "ay"
    cluster -> {
      let cl_len = list.length(cluster)
      let suffix = string.slice(word, cl_len, string.length(word))
      suffix <> string.join(cluster, "") <> "ay"
    }
  }
}

fn extract_consonant_cluster(chars: List(String), acc: List(String)) -> List(String) {
  case chars {
    [] -> acc
    ["y", ..] if acc == [] -> ["y"]
    ["y", ..] -> acc
    [c, ..rest] -> case is_vowel(c) {
      True -> acc
      False -> extract_consonant_cluster(rest, list.append(acc, [c]))
    }
  }
}

fn starts_with_vowel(word: String) -> Bool {
  case string.first(word) {
    Ok(ch) -> is_vowel(ch)
    Error(_) -> False
  }
}

fn is_vowel(c: String) -> Bool {
  list.contains(["a", "e", "i", "o", "u"], string.lowercase(c))
}
