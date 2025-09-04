module SquareRoot exposing (squareRoot)
squareRoot : Int -> Int
squareRoot radicand =
    let
        bInit =
            4 ^ (radicand |> toFloat |> logBase 4 |> floor)
        sqrt n b x =
            if b == 0 then
                x
            else if n >= x + b then
                sqrt (n - x - b) (b // 4) (x // 2 + b)
            else
                sqrt n (b // 4) (x // 2)
    in
    sqrt radicand bInit 0