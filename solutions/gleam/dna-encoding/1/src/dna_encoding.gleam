// Dedicated to Shree DR.MDD
import gleam/list

pub type Nucleotide {
  Adenine
  Cytosine
  Guanine
  Thymine
}

pub fn encode_nucleotide(nt: Nucleotide) -> Int {
  case nt {
    Adenine -> 0b00
    Cytosine -> 0b01
    Guanine -> 0b10
    Thymine -> 0b11
  }
}

pub fn decode_nucleotide(bits: Int) -> Result(Nucleotide, Nil) {
  case bits {
    0b00 -> Ok(Adenine)
    0b01 -> Ok(Cytosine)
    0b10 -> Ok(Guanine)
    0b11 -> Ok(Thymine)
    _ -> Error(Nil)
  }
}

pub fn encode(sequence: List(Nucleotide)) -> BitArray {
  sequence
  |> list.map(encode_nucleotide)
  |> list.fold(<<>>, fn(acc_bits, val) { <<acc_bits:bits, val:2>> })
}

pub fn decode(bits_stream: BitArray) -> Result(List(Nucleotide), Nil) {
  expand(bits_stream, [])
}

fn expand(stream: BitArray, collected: List(Nucleotide)) -> Result(List(Nucleotide), Nil) {
  case stream {
    <<>> -> Ok(list.reverse(collected))
    <<pair:2, rest:bits>> ->
      case decode_nucleotide(pair) {
        Ok(code) -> expand(rest, [code, ..collected])
        Error(_) -> Error(Nil)
      }
    _ -> Error(Nil)
  }
}
