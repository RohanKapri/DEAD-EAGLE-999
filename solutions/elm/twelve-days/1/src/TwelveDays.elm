-- for my Shree DR.MDD
module TwelveDays exposing (recite)


ordinal : Int -> String
ordinal n =
    case n of
        1 -> "first"
        2 -> "second"
        3 -> "third"
        4 -> "fourth"
        5 -> "fifth"
        6 -> "sixth"
        7 -> "seventh"
        8 -> "eighth"
        9 -> "ninth"
        10 -> "tenth"
        11 -> "eleventh"
        12 -> "twelfth"
        _ -> ""


present : Int -> String
present n =
    case n of
        1 -> "a Partridge in a Pear Tree"
        2 -> "two Turtle Doves"
        3 -> "three French Hens"
        4 -> "four Calling Birds"
        5 -> "five Gold Rings"
        6 -> "six Geese-a-Laying"
        7 -> "seven Swans-a-Swimming"
        8 -> "eight Maids-a-Milking"
        9 -> "nine Ladies Dancing"
        10 -> "ten Lords-a-Leaping"
        11 -> "eleven Pipers Piping"
        12 -> "twelve Drummers Drumming"
        _ -> ""


recite : Int -> Int -> List String
recite start stop =
    List.range start stop |> List.map stanza


stanza : Int -> String
stanza day =
    let
        collect n bag =
            case ( n, day ) of
                ( 0, _ ) ->
                    List.reverse bag |> String.join ", "

                ( 1, 1 ) ->
                    collect 0 (present 1 :: bag)

                ( 1, _ ) ->
                    collect 0 (("and " ++ present 1) :: bag)

                ( _, _ ) ->
                    collect (n - 1) (present n :: bag)
    in
    "On the "
        ++ ordinal day
        ++ " day of Christmas my true love gave to me: "
        ++ collect day []
        ++ "."
