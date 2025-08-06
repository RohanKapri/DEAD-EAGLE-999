{-# OPTIONS_GHC -Wno-incomplete-uni-patterns #-}
module Alphametics (solve) where
import qualified Data.List as L
import Data.List.Split ( splitOn )
import qualified Data.Map as M
import Data.Char (isAlpha)
import Data.Maybe (listToMaybe)
solve :: String -> Maybe [(Char, Int)]
solve puzzle = M.toList <$> listToMaybe solutions
    where
        solutions = [sol | sol <- permLetters, solves sol puzzle]
        allLetters = L.nub $ L.filter isAlpha puzzle
        permLetters =
            let toMap perm = M.fromList $ zip allLetters perm
            in L.map toMap $ L.permutations [0..9]
solves :: M.Map Char Int -> String -> Bool
solves perm puzzle = noLeadingZeros && sum lhsNum == rhsNum
    where
        [lhsStr, [rhsStr]] = splitOn "+" <$> splitOn "==" puzzle
        lhsInt = map (replaceLetters perm) lhsStr
        rhsInt = replaceLetters perm rhsStr
        lhsNum = map toNum lhsInt
        rhsNum = toNum rhsInt
        noLeadingZeros = all (\lst -> head lst /= 0) lhsInt && head rhsInt /= 0
replaceLetters :: M.Map Char Int -> String -> [Int]
replaceLetters perm str = L.map (perm M.!) $ L.filter isAlpha str
toNum :: [Int] -> Int
toNum = foldl (\n d -> 10*n+d) 0