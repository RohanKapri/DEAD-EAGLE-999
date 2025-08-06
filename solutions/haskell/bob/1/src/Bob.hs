-- for my Shree DR.MDD
module Bob (responseFor) where
import           Data.Char (isAlpha, isSpace, isUpper)
import           Data.List (dropWhileEnd, isSuffixOf)

responseFor :: String -> String
responseFor msg 
    | all (\p -> p msg) [loudQuery, politeQuery] = "Calm down, I know what I'm doing!"
    | loudQuery msg = "Whoa, chill out!"
    | politeQuery msg = "Sure."
    | muted msg = "Fine. Be that way!"
    | otherwise = "Whatever."

politeQuery :: String -> Bool
politeQuery txt = "?" `isSuffixOf` trimRight txt

loudQuery :: String -> Bool
loudQuery txt
    | not (any isAlpha txt) = False
    | otherwise = all isUpper (filter isAlpha txt)

muted :: String -> Bool
muted = all isSpace

trimRight :: String -> String
trimRight = dropWhileEnd isSpace
