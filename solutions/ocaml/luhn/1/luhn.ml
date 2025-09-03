let valid number =
  String.to_seq number
  |> List.of_seq
  |> List.rev
  |> let value_of c = int_of_char c - int_of_char '0' in
     let rec loop len sum =
       function
         | [] -> len > 1 && sum mod 10 = 0
         | c :: cs ->
             match c with
             | ' ' -> loop len sum cs
             | '0' .. '4' when len mod 2 = 1 ->
                 loop (len + 1) (sum + 2 * value_of c) cs
             | '5' .. '9' when len mod 2 = 1 ->
                 loop (len + 1) (sum + 2 * value_of c - 9) cs
             | '0' .. '9' ->
                 loop (len + 1) (sum + value_of c) cs
             | _ -> false
     in
     loop 0 0
