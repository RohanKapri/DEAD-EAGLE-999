module SecretHandshake (handshake) where

import Data.Bits  ( testBit )
import Data.Maybe ( catMaybes )

handshake :: Int -> [String]
handshake n = maybeReverse . catMaybes . map ($ n) $ secrets
  where secrets      = [one, ten, hundred, thousand]

        one          = ifBit 0 (Just "wink")            Nothing
        ten          = ifBit 1 (Just "double blink")    Nothing
        hundred      = ifBit 2 (Just "close your eyes") Nothing
        thousand     = ifBit 3 (Just "jump")            Nothing

        maybeReverse = ifBit 4 reverse id n

        ifBit i a b  = \m -> if testBit m i then a else b