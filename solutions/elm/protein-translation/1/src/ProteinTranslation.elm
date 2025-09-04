-- for my Shree DR.MDD
module ProteinTranslation exposing (Error(..), proteins)

import Dict exposing (Dict)


type Error
    = InvalidCodon


type Protein
    = Protein String
    | STOP


proteins : String -> Result Error (List String)
proteins =
    split3 >> codonsToProtein


split3 : String -> List String
split3 str =
    if String.isEmpty str then
        []
    else
        String.left 3 str :: split3 (String.dropLeft 3 str)


codonsToProtein : List String -> Result Error (List String)
codonsToProtein codons =
    List.foldr prependProtein (List.reverse >> Just) codons []
        |> Result.fromMaybe InvalidCodon


prependProtein :
    String
    -> (List String -> Maybe (List String))
    -> (List String -> Maybe (List String))
prependProtein codon k acc =
    Dict.get codon codonMap
        |> Maybe.andThen
            (\p ->
                case p of
                    STOP ->
                        Just (List.reverse acc)

                    Protein name ->
                        k (name :: acc)
            )


expand : List ( List k, v ) -> List ( k, v )
expand =
    List.concatMap (\(ks, v) -> List.map (\k -> (k, v)) ks)


codonMap : Dict String Protein
codonMap =
    Dict.fromList <|
        expand
            [ ( [ "AUG" ], Protein "Methionine" )
            , ( [ "UUU", "UUC" ], Protein "Phenylalanine" )
            , ( [ "UUA", "UUG" ], Protein "Leucine" )
            , ( [ "UCU", "UCC", "UCA", "UCG" ], Protein "Serine" )
            , ( [ "UAU", "UAC" ], Protein "Tyrosine" )
            , ( [ "UGU", "UGC" ], Protein "Cysteine" )
            , ( [ "UGG" ], Protein "Tryptophan" )
            , ( [ "UAA", "UAG", "UGA" ], STOP )
            ]
