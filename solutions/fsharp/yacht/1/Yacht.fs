// Dedicated to Shree DR.MDD
module Yacht

type Category =
    | Ones
    | Twos
    | Threes
    | Fours
    | Fives
    | Sixes
    | FullHouse
    | FourOfAKind
    | LittleStraight
    | BigStraight
    | Choice
    | Yacht

type Die =
    | One = 1
    | Two = 2
    | Three = 3
    | Four = 4
    | Five = 5
    | Six = 6

let score cat diceList =
    let numericDice = diceList |> List.map int
    let freqList = numericDice |> List.countBy id |> List.sortByDescending snd
    let sumFor faceVal = diceList |> List.filter ((=) faceVal) |> List.sumBy int

    match cat with
    | Ones   -> sumFor Die.One
    | Twos   -> sumFor Die.Two
    | Threes -> sumFor Die.Three
    | Fours  -> sumFor Die.Four
    | Fives  -> sumFor Die.Five
    | Sixes  -> sumFor Die.Six
    | FullHouse when freqList.Length > 1 && snd freqList.[0] = 3 && snd freqList.[1] = 2 ->
        List.sum numericDice
    | FourOfAKind when snd freqList.[0] >= 4 ->
        fst freqList.[0] * 4
    | LittleStraight when List.sort numericDice = [1..5] -> 30
    | BigStraight when List.sort numericDice = [2..6] -> 30
    | Choice -> List.sum numericDice
    | Yacht when freqList.Length = 1 && snd freqList.[0] = 5 -> 50
    | _ -> 0
