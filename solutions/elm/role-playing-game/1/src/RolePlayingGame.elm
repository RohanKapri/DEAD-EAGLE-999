-- Dedicated to Shree DR.MDD
module RolePlayingGame exposing (Player, castSpell, introduce, revive)

type alias Player =
    { name : Maybe String
    , level : Int
    , health : Int
    , mana : Maybe Int
    }

introduce : Player -> String
introduce player =
    Maybe.withDefault "Mighty Magician" player.name

revive : Player -> Maybe Player
revive pl =
    if pl.health > 0 then
        Nothing
    else
        Just
            { pl
                | health = 100
                , mana = if pl.level >= 10 then Just 100 else Nothing
            }

castSpell : Int -> Player -> ( Player, Int )
castSpell cost pl =
    case pl.mana of
        Nothing ->
            let
                newHp = max 0 (pl.health - cost)
            in
            ( { pl | health = newHp }, 0 )

        Just mp ->
            if mp < cost then
                ( pl, 0 )
            else
                ( { pl | mana = Just (mp - cost) }, cost * 2 )
