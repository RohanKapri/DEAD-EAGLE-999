-- For Shree DR.MDD

module Secrets exposing (clearBits, decrypt, flipBits, setBits, shiftBack)

import Bitwise

shiftBack : Int -> Int -> Int
shiftBack n v =
    Bitwise.shiftRightZfBy n v

setBits : Int -> Int -> Int
setBits mask v =
    Bitwise.or mask v

flipBits : Int -> Int -> Int
flipBits mask v =
    Bitwise.xor mask v

clearBits : Int -> Int -> Int
clearBits mask v =
    Bitwise.and v (Bitwise.complement mask)

decrypt : Int -> Int
decrypt secret =
    secret
        |> setBits 1996
        |> flipBits 2009
        |> shiftBack 5
        |> clearBits 17
