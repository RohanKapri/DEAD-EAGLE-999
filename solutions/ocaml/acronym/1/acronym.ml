let acronym phrase =
  let chars =
    String.uppercase_ascii phrase
    |> String.map (fun c -> if 'A' <= c && c <= 'Z' || c = '\''
                            then c
                            else ' ')
    |> String.split_on_char ' '
    |> List.filter (fun word -> String.length word > 0)
    |> List.map (fun word -> word.[0])
    |> Array.of_list
  in
  String.init (Array.length chars) (Array.get chars)
