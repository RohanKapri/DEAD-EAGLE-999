module Main exposing (..)

import Browser
import Html exposing (Html, div, input, text)
import Html.Attributes exposing (value, placeholder)
import Html.Events exposing (onInput)


-- MODEL

type alias Model =
    { content : String
    }


init : Model
init =
    { content = "" }


-- UPDATE

type Msg
    = Change String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Change newContent ->
            { model | content = newContent }


-- VIEW

isPalindrome : String -> Bool
isPalindrome str =
    let
        normalized =
            str
                |> String.trim
                |> String.toLower
                |> String.filter Char.isAlphaNum
    in
    normalized == String.reverse normalized


view : Model -> Html Msg
view model =
    div []
        [ input
            [ placeholder "Enter text to check"
            , value model.content
            , onInput Change
            ]
            []
        , div []
            [ text
                (if isPalindrome model.content then
                    "This is a palindrome"
                 else
                    "Not a palindrome"
                )
            ]
        ]


-- MAIN

main : Html Msg
main =
    Browser.sandbox
        { init = init
        , update = update
        , view = view
        }
