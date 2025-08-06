module Brackets (arePaired) where

arePaired :: String -> Bool
arePaired xs = arePaired' xs []

arePaired' :: String -> String -> Bool
arePaired' []     stack = null stack
arePaired' (x:xs) stack
    | isOpening x = arePaired' xs (x:stack)
    | isClosing x = not (null stack) && isPair (head stack, x) && arePaired' xs (tail stack)
    | otherwise   = arePaired' xs stack
    where
        isOpening = (`elem` map fst brackets)
        isClosing = (`elem` map snd brackets)
        isPair = (`elem` brackets)

brackets :: [(Char, Char)]
brackets = [('(',')'), ('[', ']'), ('{', '}')]