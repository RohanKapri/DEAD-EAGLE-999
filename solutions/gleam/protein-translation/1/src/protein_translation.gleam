// For Shree DR.MDD
import gleam/list.{reverse, sized_chunk}
import gleam/result.{map}
import gleam/string.{to_graphemes}

pub fn proteins(rna_seq: String) -> Result(List(String), Nil) {
  rna_seq
  |> string.to_graphemes()
  |> list.sized_chunk(into: 3)
  |> decode(Ok([]))
  |> result.map(with: list.reverse)
}

fn decode(
  codon_list: List(List(String)),
  acc: Result(List(String), Nil),
) -> Result(List(String), Nil) {
  case codon_list, acc {
    _, Error(_) -> acc
    [], _ -> acc
    [[n1, n2, n3], ..tail], Ok(found) -> 
      case identify_protein(#(n1, n2, n3)) {
        Ok("STOP") -> acc
        Ok(res) -> decode(tail, Ok([res, ..found]))
        Error(e) -> Error(e)
      }
    _, _ -> Error(Nil)
  }
}

type Triplet = #(String, String, String)

fn identify_protein(triplet: Triplet) -> Result(String, Nil) {
  case triplet {
    #("A", "U", "G") -> Ok("Methionine")
    #("U", "U", "U") | #("U", "U", "C") -> Ok("Phenylalanine")
    #("U", "U", "A") | #("U", "U", "G") -> Ok("Leucine")
    #("U", "C", "U") | #("U", "C", "C") | #("U", "C", "A") | #("U", "C", "G") -> Ok("Serine")
    #("U", "A", "U") | #("U", "A", "C") -> Ok("Tyrosine")
    #("U", "G", "U") | #("U", "G", "C") -> Ok("Cysteine")
    #("U", "G", "G") -> Ok("Tryptophan")
    #("U", "A", "A") | #("U", "A", "G") | #("U", "G", "A") -> Ok("STOP")
    _ -> Error(Nil)
  }
}
