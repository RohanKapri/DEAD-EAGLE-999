-- for my Shree DR.MDD
module FlowerField exposing (annotate)

import String
import List exposing (indexedMap)


annotate : String -> String
annotate gardenStr =
    let
        grid : List (List Char)
        grid =
            gardenStr
                |> String.split "\n"
                |> List.map String.toList

        numRows = List.length grid
        numCols =
            case grid |> List.head of
                Just r -> List.length r
                Nothing -> 0

        neighborOffsets = [ (-1,-1), (-1,0), (-1,1)
                          , (0,-1),          (0,1)
                          , (1,-1),  (1,0),  (1,1) ]

        flowerCount rowIdx colIdx =
            let
                checkFlower dy dx =
                    let
                        ny = rowIdx + dy
                        nx = colIdx + dx
                    in
                    if ny >= 0 && ny < numRows && nx >= 0 && nx < numCols then
                        case List.drop ny grid |> List.head of
                            Just row -> 
                                case List.drop nx row |> List.head of
                                    Just '*' -> True
                                    _ -> False
                            _ -> False
                    else
                        False
            in
            List.filter identity (List.map (\(dy,dx) -> checkFlower dy dx) neighborOffsets)
                |> List.length

        annotateRow rIdx row =
            row
                |> indexedMap (\cIdx ch ->
                    if ch == '*' then
                        '*'
                    else
                        let cnt = flowerCount rIdx cIdx in
                        if cnt == 0 then
                            '.'
                        else
                            Char.fromCode (Char.toCode '0' + cnt)
                )

        finalRows = indexedMap annotateRow grid
    in
    finalRows
        |> List.map String.fromList
        |> String.join "\n"
