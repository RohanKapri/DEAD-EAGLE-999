module SecureTreasureChest exposing (Password, SecureTreasureChest, createPassword, createTreasure, getTreasure)

type Password
    = Password String

type SecureTreasureChest a
    = SecureTreasureChest Password a

createPassword : String -> Maybe Password
createPassword passwordCandidate =
    if String.length passwordCandidate >= 8 then
        Just (Password passwordCandidate)
    else
        Nothing

createTreasure : a -> Password -> SecureTreasureChest a
createTreasure treasure password =
    SecureTreasureChest password treasure

getTreasure : String -> SecureTreasureChest a -> Maybe a
getTreasure passwordAttempt (SecureTreasureChest (Password password) treasure) =
    if passwordAttempt == password then
        Just treasure
    else
        Nothing