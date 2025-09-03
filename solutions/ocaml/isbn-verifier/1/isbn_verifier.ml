let is_valid str =
  let rec loop seq sum = function
    | 0 -> Seq.is_empty seq && sum mod 11 = 0
    | n ->
        match Seq.uncons seq with
        | Some ('X', seq) when n = 1 -> loop seq (sum + 10) 0
        | Some ('0'..'9' as c, seq) -> 
            loop seq (sum + n * Char.(code c - code '0')) (n - 1)
        | _ -> false
  in
  loop (String.to_seq str |> Seq.filter (( <> ) '-')) 0 10
