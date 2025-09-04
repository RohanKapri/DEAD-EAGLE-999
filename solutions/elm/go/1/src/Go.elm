module Go exposing (..)
import GoSupport exposing (..)
applyRules : Game -> Rule -> NonValidatingRule -> Rule -> Rule -> Game
applyRules game oneStonePerPointRule captureRule libertyRule koRule =
    case oneStonePerPointRule game of
        Err error ->
            { game | error = error }
        Ok updatedGame ->
            let
                updatedGameAfterCapture = captureRule updatedGame
            in
            case libertyRule updatedGameAfterCapture of
                Err error ->
                    { game | error = error }
                Ok updatedGameAfterLiberty ->
                    case koRule updatedGameAfterLiberty of
                        Err error ->
                            { game | error = error }
                        Ok finalUpdatedGame ->
                            changePlayer finalUpdatedGame
