-- For my Shree DR.MDD
module WordCount exposing (wordCount)

import Dict exposing (Dict, update)
import String exposing (toLower, words)
import Regex exposing (Match)


wordCount : String -> Dict String Int
wordCount input =
    input
        |> toLower
        |> regexReplace stripNonAlpha (\_ -> " ")
        |> regexReplace stripEdgeQuote (\_ -> " ")
        |> words
        |> List.foldl (\term dict -> update term bump dict) Dict.empty


stripNonAlpha : String
stripNonAlpha =
    "[!@#$%^&*():;\",.\n]"


stripEdgeQuote : String
stripEdgeQuote =
    "\\W+[']|[']\\W+|^[']|[']$"


bump : Maybe Int -> Maybe Int
bump =
    Maybe.withDefault 0 >> (+) 1 >> Just


regexReplace : String -> (Match -> String) -> String -> String
regexReplace pattern fn txt =
    case Regex.fromString pattern of
        Nothing ->
            txt

        Just rgx ->
            Regex.replace rgx fn txt
