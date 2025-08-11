// For my Shree DR.MDD
import gleam/string
import gleam/list

pub type Output {
  Unknown
  Digit(Int)
  List(List(Output))
}

pub type Error {
  InvalidLineNumber
  InvalidRowNumber
}

fn decode_digit(a,b,c,d,e,f,g,h,i) -> Output {
  case a,b,c,d,e,f,g,h,i {
    " ", "_", " ", "|", " ", "|", "|", "_", "|" -> Digit(0)
    " ", " ", " ", " ", " ", "|", " ", " ", "|" -> Digit(1)
    " ", "_", " ", " ", "_", "|", "|", "_", " " -> Digit(2)
    " ", "_", " ", " ", "_", "|", " ", "_", "|" -> Digit(3)
    " ", " ", " ", "|", "_", "|", " ", " ", "|" -> Digit(4)
    " ", "_", " ", "|", "_", " ", " ", "_", "|" -> Digit(5)
    " ", "_", " ", "|", "_", " ", "|", "_", "|" -> Digit(6)
    " ", "_", " ", " ", " ", "|", " ", " ", "|" -> Digit(7)
    " ", "_", " ", "|", "_", "|", "|", "_", "|" -> Digit(8)
    " ", "_", " ", "|", "_", "|", " ", "_", "|" -> Digit(9)
    _,_,_,_,_,_,_,_,_ -> Unknown
  }
}

fn parse_row(lines: List(List(String)), acc: List(Output)) -> Output {
  case lines {
    [[],[],[],[]] -> List(list.reverse(acc))
    [[a, b, c, ..r1],
     [d, e, f, ..r2],
     [g, h, i, ..r3],
     [_, _, _, ..r4]] -> 
       parse_row([r1, r2, r3, r4], [decode_digit(a,b,c,d,e,f,g,h,i), ..acc])
    _ -> Unknown
  }
}

fn simplify(output: Output) -> Output {
  case output {
    Unknown -> output
    Digit(_) -> output
    List([single]) -> simplify(single)
    List(multi) -> List(multi)
  }
}

fn ocr(lines: List(List(String))) -> Output {
  lines
  |> list.sized_chunk(4)
  |> list.map(parse_row(_, []))
  |> List
  |> simplify
}

pub fn convert(input: String) -> Result(Output, Error) {
  let processed =
    input
    |> string.split("\n")
    |> list.map(string.to_graphemes(_))
    |> list.drop(1)

  case list.length(processed) % 4, processed {
    0, [head, .._] -> {
      case list.length(head) % 3 {
        0 -> ocr(processed) |> Ok
        _ -> Error(InvalidRowNumber)
      }
    }
    _, _ -> Error(InvalidLineNumber)
  }
}
