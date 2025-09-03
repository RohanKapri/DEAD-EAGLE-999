let bit_of = function
  | 'A'..'Z' as c -> 1 lsl Char.(code c - code 'A')
  | 'a'..'z' as c -> 1 lsl Char.(code c - code 'a')
  | _ -> 0
let is_isogram word =
  String.to_seq word
  |> Seq.scan (fun (bits, bit) c -> (bits lor bit, bit_of c)) (0, 0)
  |> Seq.for_all (fun (bits, bit) -> bits land bit = 0)
