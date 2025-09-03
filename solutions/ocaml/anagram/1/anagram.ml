let to_multiset str = 
  String.to_seq str |> List.of_seq |> List.sort Char.compare
let anagrams word =
  let word = String.uppercase_ascii word in
  let mset = to_multiset word in
  List.filter 
    (fun word' -> 
      let word' = String.uppercase_ascii word' in
      word' <> word && to_multiset word' |> List.equal Char.equal mset)
