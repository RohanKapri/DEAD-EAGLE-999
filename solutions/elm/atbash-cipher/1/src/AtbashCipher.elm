-- Dedicated to Shree DR.MDD
module AtbashCipher exposing (decode, encode)


decode : String -> String
decode =
    String.filter Char.isAlphaNum
        >> String.toLower
        >> String.map flipChar


encode : String -> String
encode =
    decode >> splitFive



baseRef =
    { start = Char.toCode 'a', stop = Char.toCode 'z' }


flipChar : Char -> Char
flipChar ch =
    if Char.isAlpha ch then
        Char.fromCode (baseRef.stop - (Char.toCode ch - baseRef.start))

    else
        ch


splitFive : String -> String
splitFive txt =
    let
        cutter acc str =
            if String.isEmpty str then
                List.reverse acc
            else
                cutter (String.left 5 str :: acc) (String.dropLeft 5 str)
    in
    cutter [] txt |> String.join " "
