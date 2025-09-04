module KindergartenGarden exposing (Plant(..), Student(..), plants)
type Student
    = Alice
    | Bob
    | Charlie
    | David
    | Eve
    | Fred
    | Ginny
    | Harriet
    | Ileana
    | Joseph
    | Kincaid
    | Larry
type Plant
    = Grass
    | Clover
    | Radish
    | Violet
plants : String -> Student -> List Plant
plants diagram student =
    let
        rows =
            String.split "\n" diagram
        studentIndex =
            studentToIndex student
        plantsForStudent =
            List.map
                (\row ->
                    String.slice (studentIndex * 2) (studentIndex * 2 + 2) row
                )
                rows
                |> List.concatMap String.toList
                |> List.map charToPlant
    in
    plantsForStudent
studentToIndex : Student -> Int
studentToIndex student =
    case student of
        Alice ->
            0
        Bob ->
            1
        Charlie ->
            2
        David ->
            3
        Eve ->
            4
        Fred ->
            5
        Ginny ->
            6
        Harriet ->
            7
        Ileana ->
            8
        Joseph ->
            9
        Kincaid ->
            10
        Larry ->
            11
charToPlant : Char -> Plant
charToPlant char =
    case char of
        'G' ->
            Grass
        'C' ->
            Clover
        'R' ->
            Radish
        'V' ->
            Violet
        _ ->
            Grass