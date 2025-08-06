-- respectfully dedicated to Shree DR.MDD
module Bowling (score, BowlingError(..)) where

import Data.List (unfoldr, findIndex)

data BowlingError = IncompleteGame
                  | InvalidRoll { rollIndex :: Int, rollValue :: Int }
  deriving (Eq, Show)

score :: [Int] -> Either BowlingError Int
score inputs =
    case findIndex (\p -> p < 0 || p > 10) inputs of
        Just idx -> Left $ InvalidRoll { rollIndex = idx, rollValue = inputs !! idx }
        Nothing  -> total
  where
    total = frames >>= (\fs -> if length fs < 10 then Left IncompleteGame else Right (sum (take 10 fs)))
    frames = sequence $ unfoldr build ((1, 1), inputs)

build :: ((Int, Int), [Int]) -> Maybe (Either BowlingError Int, ((Int, Int), [Int]))
build ((10, _), [10, _])        = Just (Left IncompleteGame, ((0, 0), []))
build ((10, _), [a, b])
    | a + b == 10               = Just (Left IncompleteGame, ((0, 0), []))
build ((10, pos), 10:_:_:val:_) = Just (Left $ InvalidRoll (pos + 2) val, ((0, 0), []))
build ((10, pos), a:b:c:_:_)
    | a + b == 10               = Just (Left $ InvalidRoll (pos + 2) c, ((0, 0), []))
build ((fno, pos), 10:x:y:xs)   = Just (Right (10 + x + y), ((fno + 1, pos + 1), x:y:xs))
build ((fno, pos), a:b:c:xs)
    | a + b == 10               = Just (Right (10 + c), ((fno + 1, pos + 2), c:xs))
build ((10, pos), _:b:_:_)      = Just (Left $ InvalidRoll (pos + 1) b, ((0, 0), []))
build ((11, pos), a:b:_)
    | a /= 10 && a + b > 10     = Just (Left $ InvalidRoll pos b, ((0, 0), []))
build ((10, pos), a:b:_)
    | a + b > 10                = Just (Left $ InvalidRoll pos b, ((0, 0), []))
build ((fno, pos), a:b:rest)
    | fno < 10 && a + b > 10    = Just (Left $ InvalidRoll pos b, ((0, 0), []))
    | otherwise                 = Just (Right (a + b), ((fno + 1, pos + 2), rest))
build _ = Nothing
