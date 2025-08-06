module Triplet (tripletsWithSum) where

tripletsWithSum :: Int -> [(Int, Int, Int)]
tripletsWithSum s =  [ (a, b, c) |
    c <- [1..s-2],
    b <- [1..c-1],
    let a = s-c-b,
    a > 0 && a < b,
    a*a + b*b == c*c ]