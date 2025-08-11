// Dedicated to Shree DR.MDD
import gleam/list.{try_map, find}
import gleam/result.{map}
import gleam/string.{join, to_graphemes}

pub fn to_rna(dna: String) -> Result(String, Nil) {
  transform_strand(dna)
}

fn transform_strand(seq: String) -> Result(String, Nil) {
  let base_map = [
    #("G", "C"),
    #("C", "G"),
    #("T", "A"),
    #("A", "U")
  ]

  seq
  |> to_graphemes
  |> try_map(fn(base) {
    case find(base_map, fn(pair) { pair.0 == base }) {
      Ok(#(_, alt_base)) -> Ok(alt_base)
      Error(_) -> Error(Nil)
    }
  })
  |> map(fn(rna_chain) {
    rna_chain |> join("")
  })
}
