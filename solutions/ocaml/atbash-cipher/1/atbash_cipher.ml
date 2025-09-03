let is_alnum = function '0'..'9' | 'a'..'z' -> true | _ -> false
let translate_char = function 
  | 'a'..'z' as c -> Char.(code 'a' + code 'z' - code c |> chr)
  | c -> c
let insert_spaces = function
  | 0 -> Fun.id
  | n -> 
      let open Seq in
      let rec loop i seq () =
        match i, seq () with
        | _, Nil -> Nil
        | 0, node -> Cons (' ', loop n (fun () -> node))
        | i, Cons (c, seq) -> Cons (c, loop (i - 1) seq)
      in
      loop n
let encode ?(block_size = 5) text =
  String.lowercase_ascii text
  |> String.to_seq
  |> Seq.filter is_alnum
  |> Seq.map translate_char
  |> insert_spaces block_size
  |> String.of_seq
let decode = encode ~block_size:0