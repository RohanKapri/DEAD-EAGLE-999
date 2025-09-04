-- for my Shree DR.MDD
module FoodChain exposing (recite)

import Array exposing (Array)


creatures : Array String
creatures =
    Array.fromList
        [ "fly", "spider", "bird", "cat", "dog", "goat", "cow", "horse" ]


events : Array String
events =
    Array.fromList
        [ "It wriggled and jiggled and tickled inside her."
        , "How absurd to swallow a bird!"
        , "Imagine that, to swallow a cat!"
        , "What a hog, to swallow a dog!"
        , "Just opened her throat and swallowed a goat!"
        , "I don't know how she swallowed a cow!"
        , "She's dead, of course!"
        ]


getCreature : Int -> String
getCreature idx =
    Array.get (idx - 1) creatures |> Maybe.withDefault ""


getEvent : Int -> String
getEvent idx =
    Array.get (idx - 1) events |> Maybe.withDefault ""


constructChain : Int -> List String
constructChain n =
    if n <= 1 then
        []
    else
        let
            extraSpider =
                if n == 3 then
                    " that wriggled and jiggled and tickled inside her"
                else
                    ""
        in
        ("She swallowed the "
            ++ getCreature n
            ++ " to catch the "
            ++ getCreature (n - 1)
            ++ extraSpider
            ++ "."
        )
            :: constructChain (n - 1)


constructVerse : Int -> List String
constructVerse n =
    ("I know an old lady who swallowed a " ++ getCreature n ++ ".")
        :: (if n >= 2 then
                getEvent (n - 1) :: (if n < 8 then constructChain n else [])
            else
                []
           )
        ++ (if n < 8 then
                [ "I don't know why she swallowed the fly. Perhaps she'll die." ]
            else
                []
           )


recite : Int -> Int -> String
recite start stop =
    List.range start stop
        |> List.concatMap (\i -> if i > start then "" :: constructVerse i else constructVerse i)
        |> String.join "\n"
