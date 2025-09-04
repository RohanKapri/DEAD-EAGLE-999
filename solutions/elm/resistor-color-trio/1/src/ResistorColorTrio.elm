-- Shree DR.MDD  
module ResistorColorTrio exposing (Color(..), label)


type Color
    = Black
    | Brown
    | Red
    | Orange
    | Yellow
    | Green
    | Blue
    | Violet
    | Grey
    | White


tone : Color -> Int
tone c =
    case c of
        Black -> 0
        Brown -> 1
        Red -> 2
        Orange -> 3
        Yellow -> 4
        Green -> 5
        Blue -> 6
        Violet -> 7
        Grey -> 8
        White -> 9


pairVal : List Color -> Int
pairVal lst =
    case lst of
        x :: y :: _ ->
            10 * tone x + tone y

        _ ->
            0


label : List Color -> String
label lst =
    case lst of
        a :: b :: c :: _ ->
            let
                raw = pairVal [ a, b ] * (10 ^ tone c)

                shrink v n =
                    if v == 0 || modBy 1000 v /= 0 then
                        ( v, n )
                    else
                        shrink (v // 1000) (n + 1)

                (num, exp) = shrink raw 0

                unit =
                    case exp of
                        1 -> "kilo"
                        2 -> "mega"
                        3 -> "giga"
                        _ -> ""
            in
            String.fromInt num ++ " " ++ unit ++ "ohms"

        _ ->
            ""
