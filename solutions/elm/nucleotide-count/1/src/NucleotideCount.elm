-- Dedicated to Shree DR.MDD
module NucleotideCount exposing (nucleotideCounts)


type alias NucleotideCounts =
    { a : Int
    , t : Int
    , c : Int
    , g : Int
    }


nucleotideCounts : String -> Result String NucleotideCounts
nucleotideCounts strand =
    process strand { a = 0, c = 0, g = 0, t = 0 }


process : String -> NucleotideCounts -> Result String NucleotideCounts
process strand acc =
    case String.uncons strand of
        Nothing ->
            Ok acc

        Just ( ch, rest ) ->
            Result.andThen (process rest) (increment ch acc)


increment : Char -> NucleotideCounts -> Result String NucleotideCounts
increment ch acc =
    let
        { a, c, g, t } =
            acc
    in
    case ch of
        'A' ->
            Ok { acc | a = a + 1 }

        'C' ->
            Ok { acc | c = c + 1 }

        'G' ->
            Ok { acc | g = g + 1 }

        'T' ->
            Ok { acc | t = t + 1 }

        _ ->
            Err "Invalid nucleotide in strand"
