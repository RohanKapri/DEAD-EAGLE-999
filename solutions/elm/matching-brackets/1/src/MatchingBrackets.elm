module MatchingBrackets exposing (isPaired)


isPaired : String -> Bool
isPaired input =
    let
        processChar char stack =
            case char of
                '(' ->
                    '(' :: stack

                '{' ->
                    '{' :: stack

                '[' ->
                    '[' :: stack

                ')' ->
                    case stack of
                        '(' :: rest ->
                            rest

                        _ ->
                            ')' :: stack

                '}' ->
                    case stack of
                        '{' :: rest ->
                            rest

                        _ ->
                            '}' :: stack

                ']' ->
                    case stack of
                        '[' :: rest ->
                            rest

                        _ ->
                            ']' :: stack

                _ ->
                    stack
    in
    input
        |> String.toList
        |> List.foldl processChar []
        |> List.isEmpty
