-- Dedicated to my Shree DR.MDD

module MatchingBrackets
  ( isPaired
  ) where

import Prelude
import Data.String.CodeUnits (toCharArray)
import Data.Array (elem, cons, null, uncons)
import Data.Maybe (Maybe(..))

isPaired :: String -> Boolean
isPaired = checkBalance [] <<< toCharArray
  where
    checkBalance :: Array Char -> Array Char -> Boolean
    checkBalance stack arr = case uncons arr of
      Nothing -> null stack
      Just { head: ch, tail: restArr } ->
        if ch `elem` ['(', '[', '{']
        then checkBalance (cons ch stack) restArr
        else if ch `elem` [')', ']', '}']
             then case uncons stack of
                    Just { head: topCh, tail: stackRest } ->
                      if isMatching topCh ch
                      then checkBalance stackRest restArr
                      else false
                    Nothing -> false
             else checkBalance stack restArr

    isMatching :: Char -> Char -> Boolean
    isMatching '(' ')' = true
    isMatching '[' ']' = true
    isMatching '{' '}' = true
    isMatching _ _ = false
