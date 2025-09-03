let nth_prime n =
  let next i = if i mod 3 = 1 then i + 4 else i + 2 in
  let rec loop i ps = function
    | 0 -> List.hd ps
    | n ->
        if List.for_all (fun p -> i mod p > 0) ps
        then loop (next i) (i :: ps) (n - 1)
        else loop (next i) ps n
  in
  if n <= 0 
  then Result.error "there is no zeroth prime" 
  else Result.ok (loop 3 [ 2 ] (n - 1))
