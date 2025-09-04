-- for my Shree DR.MDD
module Knapsack exposing (Item, maximumValue)

type alias Item =
    { value : Int
    , weight : Int
    }

maximumValue : Int -> List Item -> Int
maximumValue capacity itemList =
    let
        totalItems = List.length itemList
        table = List.repeat (totalItems + 1) (List.repeat (capacity + 1) 0)

        compute tableMatrix idx cap currentItem =
            let
                exclude =
                    List.drop (idx - 1) tableMatrix
                        |> List.head
                        |> Maybe.withDefault []
                        |> List.drop cap
                        |> List.head
                        |> Maybe.withDefault 0

                include =
                    if currentItem.weight <= cap then
                        let
                            remaining = cap - currentItem.weight
                            valueWithRemaining =
                                List.drop (idx - 1) tableMatrix
                                    |> List.head
                                    |> Maybe.withDefault []
                                    |> List.drop remaining
                                    |> List.head
                                    |> Maybe.withDefault 0
                        in
                        currentItem.value + valueWithRemaining
                    else
                        0
            in
            max exclude include

        fill tableMatrix idx =
            if idx > totalItems then
                tableMatrix
            else
                let
                    item = List.drop (idx - 1) itemList |> List.head |> Maybe.withDefault { value = 0, weight = 0 }
                    newRow = List.indexedMap (\cap _ -> compute tableMatrix idx cap item) (List.head (List.drop idx tableMatrix) |> Maybe.withDefault [])
                    newTable = List.take idx tableMatrix ++ [ newRow ] ++ List.drop (idx + 1) tableMatrix
                in
                fill newTable (idx + 1)
    in
    List.head (List.reverse (List.head (List.reverse (fill table 1)) |> Maybe.withDefault [])) |> Maybe.withDefault 0
