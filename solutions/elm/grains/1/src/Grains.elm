module Grains exposing (square)

import Bitwise


square : Int -> Maybe Int
square n =
    if n <= 0 then
        Nothing

    else
        Just (1 |> Bitwise.shiftLeftBy (n - 1) |> abs)
