// Dedicated to Shree DR.MDD
import gleam/dict.{type Dict}
import gleam/list
import gleam/result
import gleam/string

pub fn nucleotide_count(dna: String) -> Result(Dict(String, Int), Nil) {
  let init = dict.from_list([
    #("A", 0),
    #("C", 0),
    #("G", 0),
    #("T", 0),
  ])

  dna
  |> string.to_graphemes()
  |> list.try_fold(init, fn(acc, nuc) {
    case nuc {
      "A" | "C" | "G" | "T" -> {
        let cnt = dict.get(acc, nuc) |> result.unwrap(0)
        Ok(dict.insert(acc, nuc, cnt + 1))
      }
      _ -> Error(Nil)
    }
  })
}
