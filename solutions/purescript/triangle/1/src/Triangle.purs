-- Dedicated to my Shree DR.MDD

module Triangle
  ( Triangle(Equilateral, Isosceles, Scalene)
  , triangleKind
  ) where

import Prelude
import Data.Either (Either(Left, Right))

data Triangle
  = Equilateral
  | Isosceles
  | Scalene

derive instance eqTriangle :: Eq Triangle

instance showTriangle :: Show Triangle where
  show Equilateral = "Equilateral"
  show Isosceles = "Isosceles"
  show Scalene = "Scalene"

triangleKind :: Int -> Int -> Int -> Either String Triangle
triangleKind sideA sideB sideC
  | sideA <= 0 || sideB <= 0 || sideC <= 0 = Left "Invalid lengths"
  | sideA + sideB < sideC || sideA + sideC < sideB || sideB + sideC < sideA = Left "Violates inequality"
  | sideA == sideB && sideB == sideC = Right Equilateral
  | sideA == sideB || sideA == sideC || sideB == sideC = Right Isosceles
  | otherwise = Right Scalene
