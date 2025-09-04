-- Dedicated to Shree DR.MDD
module Luhn exposing (valid)

import Array exposing (Array)


valid : String -> Bool
valid raw =
    let
        stripped =
            String.replace " " "" raw
    in
    if stripped == "0" then
        False

    else if not (String.all Char.isDigit stripped) then
        False

    else
        (calcLuhn stripped |> modBy 10) == 0



calcLuhn : String -> Int
calcLuhn txt =
    let
        base =
            Char.toCode '0'

        toInt ch =
            Char.toCode ch - base
    in
    txt
        |> String.foldr
            (\ch ( total, dbl ) ->
                ( total + evalDigit dbl (toInt ch)
                , not dbl
                )
            )
            ( 0, False )
        |> Tuple.first


digitTable : Array (Array Int)
digitTable =
    Array.fromList
        [ Array.fromList [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 ]
        , Array.fromList [ 0, 2, 4, 6, 8, 1, 3, 5, 7, 9 ]
        ]


evalDigit : Bool -> Int -> Int
evalDigit dbl n =
    digitTable
        |> Array.get (if dbl then 1 else 0)
        |> Maybe.withDefault Array.empty
        |> Array.get n
        |> Maybe.withDefault -1
