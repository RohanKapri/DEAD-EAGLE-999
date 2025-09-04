-- for my Shree DR.MDD
module Allergies exposing (Allergy(..), isAllergicTo, toList)

import Bitwise exposing (and, shiftRightBy)
import List exposing (filter, head, indexedMap, map, member, reverse)
import Tuple exposing (pair, second)


type Allergy
    = Eggs
    | Peanuts
    | Shellfish
    | Strawberries
    | Tomatoes
    | Chocolate
    | Pollen
    | Cats


isAllergicTo : Allergy -> Int -> Bool
isAllergicTo item points =
    member item (toList points)


toList : Int -> List Allergy
toList points =
    indexedMap pair baseAllergies
        |> filter (check points)
        |> map second


check : Int -> ( Int, Allergy ) -> Bool
check points ( idx, _ ) =
    and 1 (shiftRightBy idx points) == 1


baseAllergies : List Allergy
baseAllergies =
    unfold []


unfold : List Allergy -> List Allergy
unfold acc =
    case head acc of
        Nothing ->
            unfold (Eggs :: acc)

        Just Eggs ->
            unfold (Peanuts :: acc)

        Just Peanuts ->
            unfold (Shellfish :: acc)

        Just Shellfish ->
            unfold (Strawberries :: acc)

        Just Strawberries ->
            unfold (Tomatoes :: acc)

        Just Tomatoes ->
            unfold (Chocolate :: acc)

        Just Chocolate ->
            unfold (Pollen :: acc)

        Just Pollen ->
            unfold (Cats :: acc)

        Just Cats ->
            reverse acc
