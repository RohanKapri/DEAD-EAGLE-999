module TracksOnTracksOnTracks exposing (..)

-- Create a new list
newList : List String
newList =
    []

-- Define an existing list
existingList : List String
existingList =
    [ "Elm", "Clojure", "Haskell" ]

-- Add a new language to a list
addLanguage : String -> List String -> List String
addLanguage language languages =
    language :: languages

-- Count the languages in the list
countLanguages : List String -> Int
countLanguages languages =
    List.length languages

-- Reverse the list
reverseList : List String -> List String
reverseList languages =
    List.reverse languages

-- Check if list is exciting
excitingList : List String -> Bool
excitingList languages =
    case languages of
        "Elm" :: _ ->
            True

        _ :: "Elm" :: [] ->
            True

        _ :: "Elm" :: _ :: [] ->
            True

        _ ->
            False