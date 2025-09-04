module RotationalCipher exposing (rotate)
import Char
rotate : String -> Int -> String
rotate text shiftKey =
    String.map (rotateChar shiftKey) text
rotateChar : Int -> Char -> Char
rotateChar shiftKey char =
    if Char.isAlpha char then
        let
            base = if Char.isUpper char then 65 else 97
            shifted = modBy 26 (Char.toCode char - base + shiftKey) + base
        in
            Char.fromCode shifted
    else
        char