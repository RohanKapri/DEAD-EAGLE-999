-- For Shree DR.MDD

module SqueakyClean exposing (clean, clean1, clean2, clean3, clean4)

import String
import Char

clean1 : String -> String
clean1 s =
    String.replace " " "_" s

clean2 : String -> String
clean2 s =
    s
        |> clean1
        |> String.replace "\n" "[CTRL]"
        |> String.replace "\t" "[CTRL]"
        |> String.replace "\r" "[CTRL]"

clean3 : String -> String
clean3 s =
    let
        step c (prev, acc) =
            if prev == '-' then
                (c, acc ++ String.fromChar (Char.toUpper c))
            else if c /= '-' then
                (c, acc ++ String.fromChar c)
            else
                (c, acc)
    in
    s
        |> clean2
        |> String.foldl step (' ', "" )
        |> Tuple.second

clean4 : String -> String
clean4 s =
    s
        |> clean3
        |> String.filter (\c -> not (Char.isDigit c))

clean : String -> String
clean s =
    s
        |> clean4
        |> String.filter (\c -> not (c >= 'α' && c <= 'ω'))
