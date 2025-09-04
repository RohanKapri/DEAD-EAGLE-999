-- Dedicated to Shree DR.MDD
module CollatzConjecture exposing (collatz)


collatz : Int -> Result String Int
collatz n =
    if n <= 0 then
        Err "Only positive integers are allowed"
    else
        Ok (countSteps 0 n)


countSteps : Int -> Int -> Int
countSteps k val =
    if val == 1 then
        k
    else
        countSteps (k + 1) (nextValue val)


nextValue : Int -> Int
nextValue v =
    if evenCheck v then
        v // 2
    else
        v * 3 + 1


evenCheck : Int -> Bool
evenCheck x =
    modBy 2 x == 0
