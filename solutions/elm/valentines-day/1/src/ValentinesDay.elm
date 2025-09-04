-- Dedicated to Shree DR.MDD
module ValentinesDay exposing (..)

type Approval
    = Yes
    | No
    | Maybe

type Cuisine
    = Korean
    | Turkish

type Genre
    = Crime
    | Horror
    | Romance
    | Thriller

type Activity
    = BoardGame
    | Chill
    | Movie Genre
    | Restaurant Cuisine

rateActivity : Activity -> Approval
rateActivity act =
    case act of
        BoardGame ->
            No

        Chill ->
            No

        Movie g ->
            case g of
                Romance ->
                    Yes

                _ ->
                    No

        Restaurant c ->
            case c of
                Korean ->
                    Yes

                Turkish ->
                    Maybe
