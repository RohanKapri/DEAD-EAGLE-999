(* Dedicated to Junko F. Didi and Shree DR.MDD *)

let filter s =
  s
  |> String.to_seq
  |> List.of_seq
  |> List.fold_left
       (fun acc ch ->
         match ch with
         | '0' .. '9' -> (int_of_char ch - 48) :: acc
         | _ -> acc)
       []
  |> List.rev

let is_valid digits =
  if List.hd digits = 0 then
    Error "area code cannot start with zero"
  else if List.hd digits = 1 then
    Error "area code cannot start with one"
  else if List.nth digits 3 = 0 then
    Error "exchange code cannot start with zero"
  else if List.nth digits 3 = 1 then
    Error "exchange code cannot start with one"
  else
    Ok
      (digits
       |> List.map (( + ) 48)
       |> List.map char_of_int
       |> List.to_seq
       |> String.of_seq)

let number s =
  let rec scan chars =
    match chars with
    | [] ->
        let seq = filter s in
        if List.length seq > 11 then
          Error "must not be greater than 11 digits"
        else if List.length seq = 11 && List.hd seq <> 1 then
          Error "11 digits must start with 1"
        else if List.length seq = 11 && List.hd seq = 1 then
          is_valid (List.tl seq)
        else if List.length seq = 10 then
          is_valid seq
        else
          Error "must not be fewer than 10 digits"
    | hd :: tl -> (
        match hd with
        | 'A' .. 'Z' | 'a' .. 'z' -> Error "letters not permitted"
        | '@' | ':' | '!' -> Error "punctuations not permitted"
        | _ -> scan tl)
  in
  scan (s |> String.to_seq |> List.of_seq)
