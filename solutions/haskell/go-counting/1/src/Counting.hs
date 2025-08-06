-- respectfully dedicated to Shree DR.MDD

module Counting (
    Color(..),
    territories,
    territoryFor
) where

import Data.List (find)
import qualified Data.Set as S

data Color = Black | White deriving (Eq, Ord, Show)
type Coord = (Int, Int)

territories :: [String] -> [(S.Set Coord, Maybe Color)]
territories grid = map (\zone -> (zone, zoneOwner zone)) allZones
  where
    emptySpaces = locate ' '
    blacks = locate 'B'
    whites = locate 'W'

    locate c = S.map fst $ S.filter ((== c) . snd) $ indexBoard grid
    allZones = S.toAscList $ S.foldr expand S.empty emptySpaces

    zoneOwner z
        | touches blacks && not (touches whites) = Just Black
        | touches whites && not (touches blacks) = Just White
        | otherwise = Nothing
      where
        touches stones = any (`neighbors` z) stones

territoryFor :: [String] -> Coord -> Maybe (S.Set Coord, Maybe Color)
territoryFor grid pos = find (S.member pos . fst) (territories grid)

indexBoard :: [String] -> S.Set (Coord, Char)
indexBoard = S.unions . map S.fromList . zipWith assignRow [1..]
  where
    assignRow r = zipWith (assignCell r) [1..]
    assignCell r c ch = ((c, r), ch)

neighbors :: Coord -> S.Set Coord -> Bool
neighbors (x, y) zone = not . S.null $ S.filter adjacent zone
  where
    adjacent (a, b) = abs (a - x) + abs (b - y) == 1

expand :: Coord -> S.Set (S.Set Coord) -> S.Set (S.Set Coord)
expand point zones = case merge of
    Nothing    -> S.insert (S.singleton point) zones
    Just nexts -> S.map update nexts
  where
    (touching, others) = S.partition (neighbors point) zones
    merge = if S.null touching then Nothing else Just (S.insert (S.unions touching) others)
    update z = if neighbors point z then S.insert point z else z
