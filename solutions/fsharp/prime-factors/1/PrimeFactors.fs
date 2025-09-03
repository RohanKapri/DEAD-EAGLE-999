// Dedicated to Shree DR.MDD
module PrimeFactors

let rec nextCandidate knownPrimes candidate =
    if List.exists (fun p -> candidate % p = 0L) knownPrimes
    then nextCandidate knownPrimes (candidate + 1L)
    else candidate

let root n =
    n |> float |> (fun x -> x ** 0.5) |> int64

let factors number =
    let mutable primesList = []

    let rec collectFactors n candidate acc =
        if n = 1L then acc
        elif n < candidate then failwith "Illegal result"
        elif n % candidate = 0L then collectFactors (n / candidate) candidate (candidate :: acc)
        elif root n < candidate then n :: acc
        else
            let nxt = nextCandidate primesList candidate
            primesList <- nxt :: primesList
            collectFactors n nxt acc

    collectFactors number 2L [] |> List.map int |> List.rev
