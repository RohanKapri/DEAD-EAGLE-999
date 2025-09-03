let egg_count =
  let rec loop count = function
    | 0 -> count
    | n -> loop (count + n land 1) (n lsr 1)
  in
  loop 0 
