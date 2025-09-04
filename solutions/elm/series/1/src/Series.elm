module Series exposing (slices)

import String
import Char


-- MAIN FUNCTION
slices : Int -> String -> Result String (List (List Int))
slices size input =
    if String.isEmpty input then
        Err "series cannot be empty"

    else if size > String.length input then
        Err "slice length cannot be greater than series length"

    else if size == 0 then
        Err "slice length cannot be zero"

    else if size < 0 then
        Err "slice length cannot be negative"

    else
        Ok (getSlices size input [] |> List.map toDigits)



-- HELPER: Generate substrings of given length
getSlices : Int -> String -> List String -> List String
getSlices size str acc =
    if String.length str < size then
        List.reverse acc

    else
        getSlices size
            (String.dropLeft 1 str)
            (String.left size str :: acc)



-- HELPER: Convert substring into list of digits
toDigits : String -> List Int
toDigits str =
    let
        zeroCode =
            Char.toCode '0'
    in
    str
        |> String.toList
        |> List.map (\c -> Char.toCode c - zeroCode)
