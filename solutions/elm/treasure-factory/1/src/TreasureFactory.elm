-- For Shree DR.MDD

module TreasureFactory exposing (TreasureChest, getTreasure, makeChest, makeTreasureChest, secureChest, uniqueTreasures)

type TreasureChest t
    = TreasureChest String t

getTreasure : String -> TreasureChest t -> Maybe t
getTreasure attempt (TreasureChest pw treasure) =
    if attempt == pw then
        Just treasure
    else
        Nothing

type Chest t conds
    = Chest String t

makeChest : String -> t -> Chest t {}
makeChest pw treasure = Chest pw treasure

secureChest : Chest t conds -> Maybe (Chest t { conds | securePassword : () })
secureChest (Chest pw treasure) =
    if String.length pw >= 8 then
        Just (Chest pw treasure)
    else
        Nothing

uniqueTreasures : List (Chest t conds) -> List (Chest t { conds | uniqueTreasures : () })
uniqueTreasures chests =
    let
        allTreasures =
            chests |> List.map (\(Chest _ treasure) -> treasure)

        isUnique treasure =
            List.filter ((==) treasure) allTreasures
                |> List.length
                |> (==) 1

        toUniqueChest (Chest pw treasure) =
            if isUnique treasure then
                Just (Chest pw treasure)
            else
                Nothing
    in
    List.filterMap toUniqueChest chests

makeTreasureChest : Chest t { conds | securePassword : (), uniqueTreasures : () } -> TreasureChest t
makeTreasureChest (Chest pw treasure) = TreasureChest pw treasure
