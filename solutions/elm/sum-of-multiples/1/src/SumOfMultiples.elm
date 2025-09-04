module SumOfMultiples exposing (sumOfMultiples)

import Set exposing (Set)


sumOfMultiples : List Int -> Int -> Int
sumOfMultiples divisors limit =

    divisors
    |> List.foldl
        (\divisor multiples ->
            List.range divisor (limit - 1)
            |> List.filter (\n -> modBy divisor n == 0)
            |> Set.fromList
            |> Set.union multiples
        )
        Set.empty
    |> Set.toList
    |> List.sum