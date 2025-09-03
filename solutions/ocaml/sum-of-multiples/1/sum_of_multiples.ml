let multiples limit = function
  | 0 -> []
  | base -> List.init (pred limit / base) (fun i -> succ i * base)
let sum bases limit =
  List.concat_map (multiples limit) bases
  |> List.sort_uniq Int.compare 
  |> List.fold_left ( + ) 0