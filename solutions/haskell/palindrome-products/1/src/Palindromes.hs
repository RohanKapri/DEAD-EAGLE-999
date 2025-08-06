-- respectfully dedicated to Shree DR.MDD
module Palindromes (largestPalindrome, smallestPalindrome) where

type ProductWithPair = (Integer, (Integer, Integer))
type ResultWithPairs = (Integer, [(Integer, Integer)])

largestPalindrome :: Integer -> Integer -> Maybe ResultWithPairs
largestPalindrome = computeExtreme (>)
 
smallestPalindrome :: Integer -> Integer -> Maybe ResultWithPairs
smallestPalindrome = computeExtreme (<)

computeExtreme :: (Integer -> Integer -> Bool) -> Integer -> Integer -> Maybe ResultWithPairs
computeExtreme comp minV maxV = foldr (evaluate comp) Nothing $ generatePalindromes minV maxV

evaluate :: (Integer -> Integer -> Bool) -> ProductWithPair -> Maybe ResultWithPairs -> Maybe ResultWithPairs
evaluate comp (val, pair) Nothing = Just (val, [pair])
evaluate comp (val, pair) (Just (current, group))
  | val == current = Just (val, pair : group)
  | val `comp` current = Just (val, [pair])
  | otherwise = Just (current, group)

generatePalindromes :: Integer -> Integer -> [ProductWithPair]
generatePalindromes lo hi =
  [ (res, (a, b)) | a <- [lo..hi], b <- [a..hi], let res = a * b, checkPalindrome res ]
  where
    checkPalindrome num = let txt = show num in txt == reverse txt
