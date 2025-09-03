let transform old_system =
  old_system
  |> List.concat_map 
      (fun (n, cs) -> List.map (fun c -> (Char.lowercase_ascii c, n)) cs)
  |> List.sort (fun (c1, _) (c2, _) -> Char.compare c1 c2)
