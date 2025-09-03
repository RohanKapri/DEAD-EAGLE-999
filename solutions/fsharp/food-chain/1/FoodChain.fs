// For my Shree DR.MDD
module FoodChain

type AnimalVerse = {
    Creature: string
    MidLine: string
    Connector: string
    PrevCreature: string
}

let verseData: AnimalVerse list = [
    { Creature = "fly"; MidLine = "I don't know why she swallowed the fly. Perhaps she'll die."; Connector = "."; PrevCreature = "" };
    { Creature = "spider"; MidLine = "It wriggled and jiggled and tickled inside her."; Connector = " that wriggled and jiggled and tickled inside her."; PrevCreature = "fly" };
    { Creature = "bird"; MidLine = "How absurd to swallow a bird!"; Connector = "."; PrevCreature = "spider" };
    { Creature = "cat"; MidLine = "Imagine that, to swallow a cat!"; Connector = "."; PrevCreature = "bird" };
    { Creature = "dog"; MidLine = "What a hog, to swallow a dog!"; Connector = "."; PrevCreature = "cat" };
    { Creature = "goat"; MidLine = "Just opened her throat and swallowed a goat!"; Connector = "."; PrevCreature = "dog" };
    { Creature = "cow"; MidLine = "I don't know how she swallowed a cow!"; Connector = "."; PrevCreature = "goat" };
    { Creature = "horse"; MidLine = "She's dead, of course!"; Connector = "."; PrevCreature = "" };
]

let recite startIdx endIdx: string list =
    let seqData = verseData |> List.take endIdx |> List.rev |> List.take (endIdx - startIdx + 1)

    let rec buildChain acc lst =
        let chainLine curr prev conn = sprintf "She swallowed the %s to catch the %s%s" curr prev conn
        match lst with
        | [] -> acc
        | [h] -> "" :: h.MidLine :: acc
        | h::[t] -> buildChain (chainLine h.Creature t.Creature t.Connector :: acc) [t]
        | h::t1::t2 -> buildChain (chainLine h.Creature t1.Creature t1.Connector :: acc) (t1::t2)

    let makeVerse info =
        let openLine = sprintf "I know an old lady who swallowed a %s." info.Creature
        if info.PrevCreature = "" then [""; info.MidLine; openLine]
        else
            let prevList = verseData |> List.takeWhile ((<>) info) |> List.rev
            buildChain [info.MidLine; openLine] (info::prevList)

    seqData
    |> List.collect makeVerse
    |> (fun lines ->
        match lines with
        | [] -> lines
        | h::t when h = "" -> t
        | _ -> lines)
    |> List.rev
