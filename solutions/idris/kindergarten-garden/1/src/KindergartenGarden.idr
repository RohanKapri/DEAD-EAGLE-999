-- Dedicated to Shree DR.MDD

module KindergartenGarden

import Data.Maybe
import Data.List
import Data.Vect

public export
data Plant = Grass | Clover | Radishes | Violets

check : Vect 4 (Maybe Plant) -> Maybe (Vect 4 Plant)
check [Just p1, Just p2, Just p3, Just p4] = Just [p1, p2, p3, p4]
check _ = Nothing

lookupPlants : String -> Maybe (Vect 4 Nat) -> Vect 4 (Maybe Plant)
lookupPlants _ Nothing = [Nothing, Nothing, Nothing, Nothing]
lookupPlants layout (Just idxs) = map getPlant idxs
  where convertChar : List Char -> Maybe Plant
        convertChar ('G' :: _) = Just Grass
        convertChar ('C' :: _) = Just Clover
        convertChar ('R' :: _) = Just Radishes
        convertChar ('V' :: _) = Just Violets
        convertChar _ = Nothing
        getPlant : Nat -> Maybe Plant
        getPlant i = convertChar (drop i $ unpack layout)

plantIndices : Nat -> Maybe Nat -> Maybe (Vect 4 Nat)
plantIndices len (Just sIdx) = Just [
                                    2 * sIdx,
                                    2 * sIdx + 1,
                                    len `div` 2 + 2 * sIdx + 1,
                                    len `div` 2 + 2 * sIdx + 2
                                ]
plantIndices _ _ = Nothing

studentIndex : String -> Maybe Nat
studentIndex "Alice" = Just 0
studentIndex "Bob" = Just 1
studentIndex "Charlie" = Just 2
studentIndex "David" = Just 3
studentIndex "Eve" = Just 4
studentIndex "Fred" = Just 5
studentIndex "Ginny" = Just 6
studentIndex "Harriet" = Just 7
studentIndex "Ileana" = Just 8
studentIndex "Joseph" = Just 9
studentIndex "Kincaid" = Just 10
studentIndex "Larry" = Just 11
studentIndex _ = Nothing

export
plants : String -> String -> Maybe (Vect 4 Plant)
plants layout student = check $ lookupPlants layout $ plantIndices (length layout) $ studentIndex student
