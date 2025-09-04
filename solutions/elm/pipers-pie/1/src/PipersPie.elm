module PipersPie exposing (doubleFactorial, factorial, pipersPi)

-- Standard factorial function
factorial : Int -> Int
factorial n =
    if n == 0 then
        1
    else
        n * factorial (n - 1)


-- Double factorial (n!!) = n * (n-2) * (n-4) * ...
doubleFactorial : Int -> Int
doubleFactorial n =
    if n <= 0 then
        1
    else
        n * doubleFactorial (n - 2)


-- Piper’s approximation for π
pipersPi : Int -> Float
pipersPi limit =
    let
        k =
            min limit 150
    in
    case k of
        0 ->
            2

        _ ->
            (2 * toFloat (factorial k))
                / toFloat (doubleFactorial (2 * k + 1))
                + pipersPi (k - 1)
