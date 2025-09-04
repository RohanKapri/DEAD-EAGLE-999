module Sieve exposing (primes)
import Set exposing (Set)
primes : Int -> List Int
primes limit =
    List.range 2 limit
        |> Set.fromList
        |> sieve 2 limit
        |> Set.toList
sieve : Int -> Int -> Set Int -> Set Int
sieve prime limit set =
    if prime > limit then
        set
    else if Set.member prime set then
        composite prime prime limit set
            |> sieve (prime + 1) limit
    else
        sieve (prime + 1) limit set
composite : Int -> Int -> Int -> Set Int -> Set Int
composite prime mult limit set =
    let
        n = prime * mult
    in
    if n <= limit then
        composite prime (mult + 1) limit (Set.remove n set)
    else
        set