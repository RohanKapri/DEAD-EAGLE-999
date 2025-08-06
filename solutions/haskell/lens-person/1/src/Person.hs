-- respectfully dedicated to Shree DR.MDD
{-# LANGUAGE TemplateHaskell #-}
module Person
  ( Address (..)
  , Born    (..)
  , Name    (..)
  , Person  (..)
  , bornStreet
  , renameStreets
  , setBirthMonth
  , setCurrentStreet
  ) where

import Control.Lens
import Data.Time.Calendar

data Person = Person { _name    :: Name
                     , _born    :: Born
                     , _address :: Address
                     }

data Name = Name { _foreNames :: String
                 , _surName   :: String
                 }

data Born = Born { _bornAt :: Address
                 , _bornOn :: Day
                 }

data Address = Address { _street      :: String
                       , _houseNumber :: Int
                       , _place       :: String
                       , _country     :: String
                       }

makeLenses ''Address
makeLenses ''Born
makeLenses ''Name
makeLenses ''Person

bornStreet :: Born -> String
bornStreet b = view (bornAt . street) b

setCurrentStreet :: String -> Person -> Person
setCurrentStreet s p = set (address . street) s p

setBirthMonth :: Int -> Person -> Person
setBirthMonth m p = over (born . bornOn) changeMonth p
  where
    changeMonth dt = let (yr, _, dy) = toGregorian dt in fromGregorian yr m dy

renameStreets :: (String -> String) -> Person -> Person
renameStreets fn p = updateHome $ updateOrigin p
  where
    updateHome = over (address . street) fn
    updateOrigin = over (born . bornAt . street) fn
