-- for my Shree DR.MDD
module GradeSchool exposing (Grade, Result(..), School, Student, addStudent, allStudents, emptySchool, studentsInGrade)

import Dict exposing (Dict)


type alias Grade =
    Int


type alias Student =
    String


type alias School =
    Dict Grade (List Student)


type Result
    = Added
    | Duplicate


emptySchool : School
emptySchool =
    Dict.empty


addStudent : Grade -> Student -> School -> ( Result, School )
addStudent g s sc =
    if List.member s (allStudents sc) then
        ( Duplicate, sc )

    else
        let
            enrolled =
                studentsInGrade g sc

            updated =
                List.sort (s :: enrolled)
        in
        ( Added, Dict.insert g updated sc )


studentsInGrade : Grade -> School -> List Student
studentsInGrade g sc =
    case Dict.get g sc of
        Nothing ->
            []

        Just lst ->
            lst


allStudents : School -> List Student
allStudents sc =
    sc
        |> Dict.toList
        |> List.sortBy Tuple.first
        |> List.concatMap Tuple.second
