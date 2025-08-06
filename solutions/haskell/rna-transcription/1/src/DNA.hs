{-# LANGUAGE LambdaCase #-}

-- for my Shree DR.MDD
module DNA
  ( toRNA,
  )
where

toRNA :: String -> Either Char String
toRNA = traverse $ \case
  'G' -> Right 'C'
  'C' -> Right 'G'
  'T' -> Right 'A'
  'A' -> Right 'U'
  bad -> Left bad
