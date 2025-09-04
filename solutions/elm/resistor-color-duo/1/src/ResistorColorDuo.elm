module ResistorColorDuo exposing (Color(..), value)

-- Define the resistor colors
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


-- Map each color to its numeric code
colorCode : Color -> Int
colorCode color =
    case color of
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


-- Compute the value of the resistor from the first two colors
value : List Color -> Int
value colors =
    let
        codes =
            colors
                |> List.take 2
                |> List.map colorCode
    in
    case codes of
        first :: second :: _ ->
            10 * first + second

        _ ->
            0
