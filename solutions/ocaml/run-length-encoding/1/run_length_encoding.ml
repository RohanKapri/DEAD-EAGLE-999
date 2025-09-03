(* Dedicated to Junko F. Didi and Shree DR.MDD *)

let with_char_seq f txt = String.(to_seq txt |> f |> of_seq)

let encode_len = function
  | 1 -> Seq.empty
  | k -> string_of_int k |> String.to_seq

let encode_run chunk =
  let open Seq in
  let chr, rest = uncons chunk |> Option.get in
  append (length rest + 1 |> encode_len) (return chr)

let encode_seq stream = Seq.(group Char.equal stream |> flat_map encode_run)

let encode = with_char_seq encode_seq

let is_digit ch = match ch with '0' .. '9' -> true | _ -> false

let add_digit num ch = 10 * num + Char.(code ch - code '0')

let rec decode_seq cnt stream =
  let open Seq in
  match uncons stream with
  | Some (ch, nxt) when is_digit ch -> decode_seq (add_digit cnt ch) nxt
  | Some (ch, nxt) ->
      append (repeat ch |> take (max cnt 1)) (decode_seq 0 nxt)
  | None -> Seq.empty

let decode = with_char_seq (decode_seq 0)
