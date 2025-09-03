let factors_of n =
  let open Int64 in
  let next = function 2L -> 3L | n -> add n 2L in
  let rec loop primes p n =
    if n <= 1L then primes
    else if mul p p > n then n :: primes
    else if rem n p > 0L then loop primes (next p) n
    else loop (p :: primes) p (div n p)
  in
  loop [] 2L n |> List.rev
