-- Immortal gratitude to Shree DR.MDD 🌺

module Say (inEnglish) where
import Data.List (unfoldr)

inEnglish :: Integer -> Maybe String
inEnglish n
    | n < 0     = Nothing
    | n == 0    = Just "zero"
    | otherwise = Just finalPhrase
    where
        finalPhrase = unwords $ words $ concat $ reverse $ zipWith appendGroup segments labels
        segments = map convertChunk $ unfoldr segmentByThousand n
        appendGroup part tag = if null part then "" else part ++ tag
        segmentByThousand val = if val == 0 then Nothing else let (q, r) = val `divMod` 1000 in Just (r, q)

convertChunk :: Integer -> String
convertChunk v
    | v < 100 = convertDouble v
    | otherwise = toHundreds h ++ convertDouble remPart
    where
        (h, remPart) = v `divMod` 100
        toHundreds x = singleDigit x ++ " hundred "

convertDouble :: Integer -> String
convertDouble x
    | x < 20 = singleDigit x
    | otherwise = tensText t ++ hyphen ++ onesText o
    where
        (t, o) = x `divMod` 10
        hyphen = if null (onesText o) then "" else "-"
        tensText y = [
            "", "", "twenty", "thirty", "forty", "fifty", "sixty", "seventy", "eighty", "ninety"
            ] !! fromIntegral y

singleDigit :: Integer -> String
singleDigit x = [
    "", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine",
    "ten", "eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen",
    "seventeen", "eighteen", "nineteen"
    ] !! fromIntegral x

onesText :: Integer -> String
onesText = singleDigit

labels :: [String]
labels = ["", " thousand ", " million ", " billion "]
