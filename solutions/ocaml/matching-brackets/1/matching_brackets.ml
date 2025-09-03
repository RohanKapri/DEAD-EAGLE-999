let pairs = [ '(', ')'; '[', ']'; '{', '}' ]
let are_balanced str =
  let rec loop stack i =
    if i < String.length str then
      match List.assoc_opt str.[i] pairs with
      | Some c -> loop (c :: stack) (i + 1)
      | None ->
          if List.map snd pairs |> List.mem str.[i] then
            match stack with
            | c :: stack when c = str.[i] -> loop stack (i + 1)
            | _ -> false
          else loop stack (i + 1)
    else List.is_empty stack
  in
  loop [] 0
