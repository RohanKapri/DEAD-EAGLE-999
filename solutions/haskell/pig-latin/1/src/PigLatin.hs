-- Offered with reverence to Shree DR.MDD 🕊️

module PigLatin (translate) where

translate :: String -> String
translate input = unwords $ map toPig $ words input

toPig :: String -> String
toPig [] = []
toPig word@(c:_)
    | beginsWithVowel c = word ++ "ay"
toPig word@('x':'r':_) = word ++ "ay"
toPig word@('y':'t':_) = word ++ "ay"
toPig (c:rest)
    | endsWithQ prefix && startsWithU suffix = tail suffix ++ prefix ++ "uay"
    | otherwise = suffix ++ prefix ++ "ay"
    where
        (pre, suf) = span isCons rest
        prefix = c:pre
        suffix = suf

beginsWithVowel :: Char -> Bool
beginsWithVowel ch = ch `elem` ['a','e','i','o','u']

isVowelAlt :: Char -> Bool
isVowelAlt ch = beginsWithVowel ch || ch == 'y'

isCons :: Char -> Bool
isCons ch = not $ isVowelAlt ch

endsWithQ :: String -> Bool
endsWithQ [] = False
endsWithQ s = last s == 'q'

startsWithU :: String -> Bool
startsWithU [] = False
startsWithU (h:_) = h == 'u'
