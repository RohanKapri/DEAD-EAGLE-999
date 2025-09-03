let rec gcd x = function 0 -> x | y -> gcd y (x mod y)
let rec try_change change = function
  | 0, _, _ -> Some (List.sort Int.compare change)
  | _, 0, _ | _, _, [] -> None
  | target, count, coin :: coins ->
      match try_change change (target, count, coins) with
      | Some change -> Some change
      | None -> 
          try_change 
            (coin :: change) 
            (target - coin, count - 1, coin :: coins)
let make_change ~target ~coins =
  let open Result in
  if target < 0
  then error "target can't be negative"
  else if target mod List.fold_left gcd 0 coins > 0
  then error "can't make target with given coins"
  else
    let rec loop count =
      match try_change [] (target, count, coins) with
      | Some change -> ok change
      | None -> loop (count + 1)
    in
    loop 0