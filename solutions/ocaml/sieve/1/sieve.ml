let primes n =
  let sieve = Array.make (n+1) true in
  sieve.(0) <- false;
  sieve.(1) <- false;
  for p = 2 to int_of_float (sqrt (float_of_int n)) do
    if sieve.(p) then
      let rec mark_multiples i =
        if i <= n then begin
          sieve.(i) <- false;
          mark_multiples (i+p)
        end
      in
      mark_multiples (2*p)
  done;
  let rec collect_primes p acc =
    if p > n then List.rev acc
    else if sieve.(p) then collect_primes (p+1) (p::acc)
    else collect_primes (p+1) acc
  in
  collect_primes 2 []