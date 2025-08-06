module Poker (bestHands) where

import Data.List (sort, group, sortOn, sortBy, groupBy, maximumBy)
import Data.Ord (comparing)

data Suit = Spade | Heart | Club | Diamond deriving (Eq)

instance Show Suit where
    show Spade   = "S"
    show Heart   = "H"
    show Club    = "C"
    show Diamond = "D"

readSuit :: Char -> Suit
readSuit 'S' = Spade
readSuit 'H' = Heart
readSuit 'C' = Club
readSuit 'D' = Diamond

data Value = Two | Three | Four | Five | Six | Seven | Eight | Nine | Ten |
 Jack | Queen | King | Ace deriving (Eq, Ord, Enum)

instance Show Value where
    show Two    = "2"
    show Three  = "3"
    show Four   = "4"
    show Five   = "5"
    show Six    = "6"
    show Seven  = "7"
    show Eight  = "8"
    show Nine   = "9"
    show Ten    = "10"
    show Jack   = "J"
    show Queen  = "Q"
    show King   = "K"
    show Ace    = "A"

readValue :: String -> Value
readValue ['2'] = Two
readValue ['3'] = Three
readValue ['4'] = Four
readValue ['5'] = Five
readValue ['6'] = Six
readValue ['7'] = Seven
readValue ['8'] = Eight
readValue ['9'] = Nine
readValue "10" = Ten
readValue ['J'] = Jack
readValue ['Q'] = Queen
readValue ['K'] = King
readValue ['A'] = Ace


data Card = Card 
    {
    val::Value,
    suit:: Suit
    }

instance Eq Card where
    (==) x y = val x == val y

instance Show Card where
    show (Card v s) = show v ++ show s

instance Ord Card where
    compare (Card v1 _) (Card v2 _) = compare v1 v2


toCard :: String -> Card
toCard [x,y] = Card (readValue [x]) (readSuit y)
toCard [x,y,z] = Card (readValue [x,y]) (readSuit z)

data Hand =
    Invalid | HighCard Card Card Card Card Card | Pair Card Card Card Card |
    TwoPair Card Card Card | ThreeOfKind Card Card Card |
    Straight Card | Flush Card | FullHouse Card Card | FourOfKind Card Card|
    StraightFlush Card deriving (Show, Eq, Ord)

toHand :: [Card] -> Hand
toHand cs
    | length cs /= 5                = Invalid
    | isFlush cs && isStraight cs   = StraightFlush straightMax
    | isFlush cs                    = Flush (maximum cs)
    | isStraight cs                 = Straight straightMax
    | otherwise                     = runs cs
    where
        isFiveHigh =
            val (maximum cs) == Ace &&
            val (minimum cs) == Two
        straightMax = if isFiveHigh then head $ filter (\x -> val x == Five) cs else maximum cs

showCardHand :: [Card] -> String
showCardHand = unwords . map show

runs :: [Card] -> Hand
runs cs = case lengths of
    [4,1]       -> FourOfKind (get 0) (get 1)
    [3,2]       -> FullHouse (get 0) (get 1)
    [3,1,1]     -> ThreeOfKind (get 0) (get 1) (get 2)
    [2,2,1]     -> TwoPair (get 0) (get 1) (get 2)
    [2,1,1,1]   -> Pair (get 0) (get 1) (get 2) (get 3)
    [1,1,1,1,1] -> HighCard (get 0) (get 1) (get 2) (get 3) (get 4)
    _           -> Invalid
    where
        sorted   = sortBy (comparing val) cs
        grouped  = groupBy (\x y -> val x == val y) sorted
        gLengths = reverse $ sortOn snd $ map head grouped `zip` map length grouped
        lengths  = map snd gLengths
        get n    = fst $ gLengths !! n


isFlush :: [Card] -> Bool
isFlush cs = all (== h) $ map suit cs
    where h = suit $ head cs

isStraight :: [Card] -> Bool
isStraight cs =
    vs == [minimum vs..maximum vs] ||
    maximum vs == Ace &&
    init vs == [Two,Three,Four,Five]
    where vs = sort $ map val cs

toCards :: String -> [Card]
toCards = map toCard . words

validSuit :: Char -> Bool
validSuit c = c `elem` "SCHD"

validCard :: String -> Bool
validCard [x,y]   = x `elem` ['1'..'9']++"JQKA" && validSuit y
validCard [x,y,z] = x == '1' && y == '0' && validSuit z
validCard _ = False

bestHands :: [String] -> Maybe [String]
bestHands xxs = if all validCard (concatMap words xxs) && 
                   all (==5) (map (length . words) xxs) 
                then Just $ map (showCardHand . fst) $ filter (eqHand h) hands
                else Nothing

    where 
        hs          = map toCards xxs
        hands       = hs `zip` map toHand hs
        h           = snd $ maximumBy (comparing snd) hands
        eqHand x y  = x == snd y