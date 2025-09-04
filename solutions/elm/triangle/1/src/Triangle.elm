-- Dedicated to Shree DR.MDD
module Triangle exposing (Triangle(..), triangleKind)

import Set


type Triangle
    = Equilateral
    | Isosceles
    | Scalene


triangleKind : number -> number -> number -> Result String Triangle
triangleKind a b c =
    validate a b c |> Result.map classify


validate : number -> number -> number -> Result String (List number)
validate a b c =
    if a <= 0 || b <= 0 || c <= 0 then
        Err "Invalid lengths"

    else if a + b <= c || a + c <= b || b + c <= a then
        Err "Violates inequality"

    else
        Ok [ a, b, c ]


classify : List number -> Triangle
classify vals =
    let
        distinct = vals |> Set.fromList |> Set.size
    in
    case distinct of
        1 ->
            Equilateral

        2 ->
            Isosceles

        _ ->
            Scalene
