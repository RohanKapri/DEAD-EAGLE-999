let annotate b =
  let board = List.map Bytes.of_string b |> Array.of_list in
  let get_char (i, j) = Bytes.get board.(i) j in
  let set_char (i, j) = Bytes.set board.(i) j in
  let m, n = 
    match Array.length board with
    | 0 -> (0, 0)
    | m -> (m, Bytes.length board.(0))
  in
  let deltas = List.to_seq [ -1; 0; 1 ] in
  let open Seq in
  product (init m Fun.id) (init n Fun.id)
  |> filter (fun pos -> get_char pos <> '*')
  |> iter (fun (i, j) -> 
      product deltas deltas
      |> map (fun (di, dj) -> (i + di, j + dj))
      |> filter (fun (i, j) -> 0 <= i && i < m && 0 <= j && j < n)
      |> map get_char
      |> map (function '*' -> 1 | _ -> 0)
      |> fold_left ( + ) 0
      |> (function 0 -> ' ' | x -> Char.(code '0' + x |> chr))
      |> set_char (i, j));
  Array.to_list board |> List.map Bytes.to_string