type dominoe = (int * int)

let chain =
  let rec find chain (k, l) =
    let try_add (m, n) doms doms' =
      match find ((m, n) :: chain) (m, l) (doms @ doms', []) with
      | None -> find chain (k, l) (doms, (m, n) :: doms')
      | Some chain -> Some chain
    in
    function
      | [], [] when k = l -> Some chain
      | [], _ -> None
      | (m, n) :: doms, doms' when m = k -> try_add (n, m) doms doms'
      | (m, n) :: doms, doms' when n = k -> try_add (m, n) doms doms'
      | dom :: doms, doms' -> find chain (k, l) (doms, dom :: doms')
  in
  function
    | [] -> Some []
    | (m, n) :: doms -> find [ (m, n) ] (m, n) (doms, [])
