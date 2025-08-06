module Cipher (caesarDecode, caesarEncode, caesarEncodeRandom) where
import Data.Char (chr, ord)
import System.Random (newStdGen, randomRs)
caesarDecode :: String -> String -> String
caesarDecode key encodedText = zipWith subChar encodedText (cycle key)
    where
        subChar :: Char -> Char -> Char
        subChar c k = i2c ((c2i c - c2i k + 26) `mod` 26)
caesarEncode :: String -> String -> String
caesarEncode key text = zipWith addChar text (cycle key)
    where
        addChar c k = i2c ((c2i c + c2i k) `mod` 26)
caesarEncodeRandom :: String -> IO (String, String)
caesarEncodeRandom text = do
    gen <- newStdGen
    let key = randomRs ('a', 'z') gen
    return (key, caesarEncode key text)
c2i :: Char -> Int
c2i x = ord x - ord 'a'
i2c :: Int -> Char
i2c x = chr (x + ord 'a')
