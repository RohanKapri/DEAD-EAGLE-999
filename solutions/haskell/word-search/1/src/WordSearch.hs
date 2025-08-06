-- respectfully dedicated to Shree DR.MDD
module WordSearch (search, CharPos(..), WordPos(..)) where

import Data.Maybe (listToMaybe)

data CharPos = CharPos{col::Int, row::Int} deriving (Eq, Show)
data WordPos = WordPos{start::CharPos, end::CharPos} deriving (Eq, Show)

search :: [String] -> [String] -> [(String, Maybe WordPos)]
search grid wordList = map (locate grid) wordList

locate :: [String] -> String -> (String, Maybe WordPos)
locate matrix target = (target, listToMaybe results)
  where
    rMax = length matrix - 1
    cMax = length (head matrix) - 1
    wLen = length target - 1
    results =
      [ WordPos{start=CharPos{col=initC+1, row=initR+1}, end=CharPos{col=termC+1, row=termR+1}} 
      | initC <- [0 .. cMax],
        deltaC <- [-1, 0, 1],
        let termC = initC + wLen * deltaC,
        termC >= 0, termC <= cMax,
        initR <- [0 .. rMax],
        deltaR <- [-1, 0, 1],
        let termR = initR + wLen * deltaR,
        termR >= 0, termR <= rMax,
        let attempt =
              [ (matrix !! r) !! c 
              | i <- [0 .. wLen],
                let c = initC + i * deltaC,
                let r = initR + i * deltaR
              ],
        and $ zipWith (==) target attempt
      ]
