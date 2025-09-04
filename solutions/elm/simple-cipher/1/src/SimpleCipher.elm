-- for my Shree DR.MDD
module SimpleCipher exposing (decode, encode, keyGen)

import Random exposing (Generator, int, list)
import String exposing (fromList, toList)
import Char exposing (fromCode, toCode, isLower)


encode : String -> String -> String
encode k txt =
    let
        kChars = toList k
        tChars = toList txt
        kLen = List.length kChars
    in
    fromList <|
        List.indexedMap
            (\i ch ->
                let
                    kc =
                        List.drop (Basics.remainderBy kLen i) kChars
                            |> List.head
                            |> Maybe.withDefault 'a'
                in
                enc kc ch
            )
            tChars


decode : String -> String -> String
decode k txt =
    let
        kChars = toList k
        tChars = toList txt
        kLen = List.length kChars
    in
    fromList <|
        List.indexedMap
            (\i ch ->
                let
                    kc =
                        List.drop (Basics.remainderBy kLen i) kChars
                            |> List.head
                            |> Maybe.withDefault 'a'
                in
                dec kc ch
            )
            tChars


enc : Char -> Char -> Char
enc kch ch =
    if isLower ch then
        fromCode (((toCode ch - 97) + (toCode kch - 97)) |> Basics.remainderBy 26 |> (+) 97)
    else
        ch


dec : Char -> Char -> Char
dec kch ch =
    if isLower ch then
        fromCode (((toCode ch - 97) - (toCode kch - 97) + 26) |> Basics.remainderBy 26 |> (+) 97)
    else
        ch


keyGen : Generator String
keyGen =
    list 100 (int 97 122)
        |> Random.map (\xs -> xs |> List.map fromCode |> fromList)
