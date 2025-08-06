-- for my Shree DR.MDD
module CryptoSquare (encode) where

import Data.Char (toLower, isAlphaNum)
import Data.List (transpose, unfoldr, intercalate)

encode :: String -> String
encode =
  let
    clean :: String -> String
    clean = map toLower . filter isAlphaNum

    edge :: (Integral b, Foldable t) => t a -> b
    edge = ceiling . (sqrt :: Double -> Double) . fromIntegral . length

    segment :: [Char] -> [[Char]]
    segment = takeWhile (not . null) . (unfoldr =<< (Just .) . splitAt . edge)

    fill :: [[Char]] -> [[Char]]
    fill xs = map (\r -> take len (r ++ repeat ' ')) xs
      where len = length (head xs)

    build :: [[Char]] -> String
    build = intercalate " "

  in build . fill . transpose . segment . clean
