module Diamond exposing (rows)
import Char
rows : Char -> String
rows letter =
    let
        alphabet = List.range (Char.toCode 'A') (Char.toCode letter)
        size = List.length alphabet
        makeLine char =
            let
                index = Char.toCode char - Char.toCode 'A'
                outerSpaces = String.repeat (size - index - 1) "_"
                innerSpaces = if char == 'A' then "" else String.repeat (2 * index - 1) "_"
                middle = if char == 'A' then String.fromChar char 
                         else String.fromChar char ++ innerSpaces ++ String.fromChar char
            in
                outerSpaces ++ middle ++ outerSpaces
        upperLines = alphabet |> List.map Char.fromCode |> List.map makeLine
        lowerLines = 
            if Char.toCode letter == Char.toCode 'A' then 
                [] 
            else 
                List.take (size - 1) upperLines |> List.reverse
    in
    String.join "\n" (upperLines ++ lowerLines)