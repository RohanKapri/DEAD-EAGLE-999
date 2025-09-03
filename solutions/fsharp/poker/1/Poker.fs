module Poker

type CardRank = | Ace | King | Queen | Jack | Ten | Nine | Eight | Seven | Six | Five | Four | Three | Two
type Suit = | Hearts | Diamonds | Spades | Clubs
type Card = { Rank: CardRank; Suit: Suit }

let parseRankMap = [|("2", Two); ("3", Three); ("4", Four); ("5", Five); ("6", Six); ("7", Seven); ("8", Eight); ("9", Nine); ("10", Ten); ("J", Jack); ("Q", Queen); ("K", King); ("A", Ace)|] |> Map.ofArray
let parseSuitMap = [|("H", Hearts); ("D", Diamonds); ("S", Spades); ("C", Clubs)|] |> Map.ofArray
let commonRanks = [|(Two, 2); (Three, 3); (Four, 4); (Five, 5); (Six, 6); (Seven, 7); (Eight, 8); (Nine, 9); (Ten, 10); (Jack, 11); (Queen, 12); (King, 13)|] |> Map.ofArray
let aceHighRanks = commonRanks.Add(Ace, 14)
let aceLowRanks = commonRanks.Add(Ace, 1)
let categoryGap = 800000
let firstCardGap = 15
let secondCardGap = firstCardGap * firstCardGap
let thirdCardGap = secondCardGap * firstCardGap
let fourthCardGap = thirdCardGap * firstCardGap

let rankHand (original: string) : int =
  let parsed = original.Split(' ') |> Array.map (fun s -> { Rank = parseRankMap[s.Substring(0, s.Length - 1)]; Suit = parseSuitMap[s.Substring(s.Length - 1)] })
  let aceHighRanked = parsed |> Array.map (fun c -> aceHighRanks[c.Rank]) |> Array.sortDescending
  let getAllCardValues () = aceHighRanked.[0] * fourthCardGap + aceHighRanked.[1] * thirdCardGap + aceHighRanked.[2] * secondCardGap + aceHighRanked.[3] * firstCardGap + aceHighRanked.[4]
  let straightHighCard =
    if seq { 0 .. 3 } |> Seq.forall (fun i -> aceHighRanked.[i] - 1 = aceHighRanked.[i + 1])
    then Some aceHighRanked.[0]
    else
      let aceLowRanked = parsed |> Array.map (fun c -> aceLowRanks[c.Rank]) |> Array.sortDescending
      if seq { 0 .. 3 } |> Seq.forall (fun i -> aceLowRanked.[i] - 1 = aceLowRanked.[i + 1])
      then Some aceLowRanked.[0]
      else None
  let isFlush = parsed |> Seq.map (fun c -> c.Suit) |> Seq.distinct |> Seq.length = 1
  match isFlush, straightHighCard with
  | true, Some h -> categoryGap * 8 + h
  | _, _ ->
    let rankGrouped = aceHighRanked |> Array.countBy id |> Array.sortByDescending snd
    if snd rankGrouped.[0] = 4
    then categoryGap * 7 + fst rankGrouped.[0] * firstCardGap + fst rankGrouped.[1]
    elif snd rankGrouped.[0] = 3 && snd rankGrouped.[1] = 2
    then categoryGap * 6 + fst rankGrouped.[0] * firstCardGap + fst rankGrouped.[1]
    elif isFlush
    then categoryGap * 5 + getAllCardValues ()
    else
      match straightHighCard with
      | Some h -> categoryGap * 4 + h
      | None ->
        if snd rankGrouped.[0] = 3
        then categoryGap * 3 + fst rankGrouped.[0] * secondCardGap + fst rankGrouped.[1] * firstCardGap + fst rankGrouped.[2]
        elif snd rankGrouped.[0] = 2 && snd rankGrouped.[1] = 2
        then categoryGap * 2 + fst rankGrouped.[0] * secondCardGap + fst rankGrouped.[1] * firstCardGap + fst rankGrouped.[2]
        elif snd rankGrouped.[0] = 2
        then categoryGap + fst rankGrouped.[0] * thirdCardGap + fst rankGrouped.[1] * secondCardGap + fst rankGrouped.[2] * firstCardGap + fst rankGrouped.[3]
        else getAllCardValues ()

let bestHands (hands: string list) =
  hands |> List.groupBy rankHand |> List.maxBy fst |> snd
