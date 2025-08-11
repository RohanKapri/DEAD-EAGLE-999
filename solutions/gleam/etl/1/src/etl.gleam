import gleam/dict.{type Dict}
import gleam/list
import gleam/string

pub fn transform(legacy: Dict(Int, List(String))) -> Dict(String, Int) {
  dict.fold(legacy, dict.new(), fn(acc, score, letters) {
    list.fold(letters, acc, fn(inner_acc, letter) {
      dict.insert(inner_acc, string.lowercase(letter), score)
    })
  })
}