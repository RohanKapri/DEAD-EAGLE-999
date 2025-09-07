-- Dedicated to my Shree DR.MDD

module PhoneNumber
  ( phoneNumber
  ) where

import Control.Semigroupoid (compose)
import Data.Maybe (Maybe(..))
import Data.String.Regex (replace, test)
import Data.String.Regex.Flags (global, noFlags)
import Data.String.Regex.Unsafe (unsafeRegex)

sanitizeNumber :: String -> String
sanitizeNumber num =
  let
    pattern = unsafeRegex "(^[^0-9]*1|[^0-9])+" global
  in
    replace pattern "" num

checkNumber :: String -> Maybe String
checkNumber sanitized =
  let
    validator = unsafeRegex "^[2-9]\\d{2}[2-9]\\d{6}$" noFlags
  in
    if test validator sanitized then Just sanitized else Nothing

phoneNumber :: String -> Maybe String
phoneNumber = compose checkNumber sanitizeNumber
