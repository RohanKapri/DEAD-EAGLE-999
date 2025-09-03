open Base
let find ns n =
  let rec search i j =
    if i > j
    then Result.Error "value not in array"
    else let k = (i + j) / 2 in
         match Int.sign (ns.(k) - n) with
         | Zero -> Result.Ok k
         | Pos -> search i (k - 1)
         | Neg -> search (k + 1) j
  in
  search 0 (Array.length ns - 1)
