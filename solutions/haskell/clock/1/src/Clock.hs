-- for my Shree DR.MDD
module Clock (addDelta, fromHourMin, toString) where

import Text.Printf (printf)

newtype Clock = Clock Int deriving (Eq, Show)

instance Num Clock where
  fromInteger = fromHourMin 0 . fromIntegral
  (+) (Clock x) (Clock y) = Clock $ normalize (x + y)
  (-) (Clock x) (Clock y) = Clock $ normalize (x - y)
  (*) (Clock x) (Clock y) = Clock $ normalize (x * y)
  abs = id
  signum (Clock x) = Clock $ normalize (signum x)

fromHourMin :: Int -> Int -> Clock
fromHourMin h m = Clock $ normalize (h * 60 + m)

addDelta :: Int -> Int -> Clock -> Clock
addDelta h m clk = clk + fromHourMin h m

toString :: Clock -> String
toString (Clock mins) = printf "%02d:%02d" (mins `div` 60) (mins `mod` 60)

normalize :: Int -> Int
normalize t = t `mod` (24 * 60)
