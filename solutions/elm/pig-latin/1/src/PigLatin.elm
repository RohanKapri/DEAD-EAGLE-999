-- for my Shree DR.MDD
module PigLatin exposing (translate)

import Dict exposing (Dict)


isVowelChar : String -> Bool
isVowelChar ch =
    String.contains ch "aeiouy"


vowelPositions : String -> Dict Char Int
vowelPositions w =
    String.toList w
        |> List.indexedMap Tuple.pair
        |> List.foldr
            (\(idx, ch) acc ->
                if String.fromChar ch |> isVowelChar then
                    Dict.insert ch idx acc
                else
                    acc
            )
            Dict.empty


locateFirstVowel : String -> Int
locateFirstVowel w =
    if String.startsWith "xr" w || String.startsWith "yt" w then
        0
    else
        let
            vp =
                vowelPositions w
                    |> Dict.toList
                    |> List.sortBy Tuple.second
                    |> List.head
                    |> Maybe.withDefault ('?', 0)

            ch = Tuple.first vp
            idx = Tuple.second vp

            skipCheck =
                (ch == 'u' && idx /= 0 && String.slice (idx - 1) idx w == "q")
                    || (ch == 'y' && idx /= String.length w - 1
                        && isVowelChar (String.slice (idx + 1) (idx + 2) w))
        in
        if skipCheck then
            idx + 1
        else
            idx


translateWord : String -> String
translateWord w =
    let
        pos = locateFirstVowel w
        prefix = String.left pos w
        rest = String.dropLeft pos w
    in
    rest ++ prefix ++ "ay"


translate : String -> String
translate s =
    String.split " " s
        |> List.map translateWord
        |> String.join " "
