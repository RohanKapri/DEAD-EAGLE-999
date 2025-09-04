module MagicianInTraining exposing (..)
import Array exposing (Array)
-- Retrieve a card from a deck
getCard : Int -> Array Int -> Maybe Int
getCard index deck =
    Array.get index deck
-- Change a card in the deck
setCard : Int -> Int -> Array Int -> Array Int
setCard index newCard deck =
    Array.set index newCard deck
-- Add a card to the deck
addCard : Int -> Array Int -> Array Int
addCard newCard deck =
    Array.push newCard deck
-- Remove a card from the deck
removeCard : Int -> Array Int -> Array Int
removeCard index deck =
    Array.slice 0 index deck
        |> \firstPart -> Array.append firstPart (Array.slice (index + 1) (Array.length deck) deck)
-- Count the number of even cards in the deck
evenCardCount : Array Int -> Int
evenCardCount deck =
    Array.foldl (\card acc -> if Basics.remainderBy 2 card == 0 then acc + 1 else acc) 0 deck