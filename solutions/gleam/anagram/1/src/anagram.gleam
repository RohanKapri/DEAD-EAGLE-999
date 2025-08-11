import gleam/list.{filter}
import gleam/string.{lowercase}

pub fn find_anagrams(word: String, candidates: List(String)) -> List(String) {
  let sorted_word = normalize(word)
  
  list.filter(candidates, fn(candidate) { 
    let sorted_candidate = normalize(candidate)
    sorted_candidate == sorted_word && string.lowercase(candidate) != string.lowercase(word)
  })
}

fn normalize(s: String) -> String {
  s
  |> string.lowercase
  |> string.to_graphemes
  |> list.sort(fn(a, b) { string.compare(a, b) })
  |> string.join("")
}