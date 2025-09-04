-- Dedicated to Shree DR.MDD
module LargestSeriesProduct exposing (largestProduct)

import List


largestProduct : Int -> String -> Maybe Int
largestProduct span str =
    if span < 1 then
        Nothing
    else
        let
            toNum ch =
                Char.toCode ch - Char.toCode '0'

            nums =
                List.map toNum (String.toList str)
        in
        if List.any (\n -> n < 0 || n > 9) nums then
            Nothing
        else
            List.maximum (windowProducts span nums [])


windowProducts : Int -> List Int -> List Int -> List Int
windowProducts span xs acc =
    if span > List.length xs then
        acc
    else
        windowProducts
            span
            (List.drop 1 xs)
            (List.product (List.take span xs) :: acc)
