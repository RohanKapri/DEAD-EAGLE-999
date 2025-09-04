-- for my Shree DR.MDD
module Acronym exposing (abbreviate)


abbreviate : String -> String
abbreviate phrase =
    build "init" "" (String.toUpper phrase)


build : String -> String -> String -> String
build mode acc str =
    case String.uncons str of
        Nothing ->
            String.reverse acc

        Just (ch, remain) ->
            if mode == "init" && Char.isAlpha ch then
                build "word" (String.cons ch acc) remain

            else if mode == "word" && not (validChar ch) then
                build "init" acc remain

            else
                build mode acc remain


validChar : Char -> Bool
validChar c =
    Char.isAlpha c || c == '\''
