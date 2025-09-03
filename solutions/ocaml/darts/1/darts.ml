let score x y =
  let r = x *. x +. y *. y in
  [ (1., 10); (25., 5); (100., 1) ]
  |> List.find_opt (fun (rmax, _) -> r <= rmax)
  |> function None -> 0 | Some (_, pts) -> pts
