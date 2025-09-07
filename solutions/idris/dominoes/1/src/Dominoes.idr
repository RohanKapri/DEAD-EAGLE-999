-- Dedicated to my Shree DR.MDD

module Dominoes

import Data.List
import Data.Vect

vmap : (a -> b) -> Vect n a -> Vect n b
vmap _ [] = []
vmap f (hd :: tl) = (f hd) :: (vmap f tl)

computeTally : List (Vect 2 (Fin 7)) -> Vect 7 Nat
computeTally = go (replicate 7 (the Nat 0))
  where go : Vect 7 Nat -> List (Vect 2 (Fin 7)) -> Vect 7 Nat
        go tally [] = tally
        go tally ((l :: r :: []) :: rest) = go (updateAt l S (updateAt r S tally)) rest

root : Vect 7 (Fin 7) -> Fin 7 -> Fin 7
root table i = if prnt == i then i
               else root table prnt
  where prnt : Fin 7
        prnt = index i table

parents : List (Vect 2 (Fin 7)) -> Vect 7 (Fin 7)
parents doms = build [0, 1, 2, 3, 4, 5, 6] doms
  where build : Vect 7 (Fin 7) -> List (Vect 2 (Fin 7)) -> Vect 7 (Fin 7)
        build table [] = table
        build table ((l :: r :: []) :: rest) = build (replaceAt (root table r) (root table l) table) rest

initial : List (Vect 2 (Fin 7)) -> Fin 7
initial [] = 0
initial ((l :: r :: []) :: _) = l

export
canChain : List (Vect 2 (Fin 7)) -> Bool
canChain doms = (isNil doms) || (allEven && connectedAll)
  where tally : Vect 7 Nat
        tally = computeTally doms
        onlyEven : Vect n Nat -> Bool
        onlyEven [] = True
        onlyEven (x :: xs) = (x `mod` 2 == 0) && (onlyEven xs)
        allEven = onlyEven tally
        domParents = parents doms
        domRoots = vmap (root domParents) domParents
        firstRoot = root domParents (initial doms)
        connectedAll = find (\e => ((index e tally > 0) && (index e domRoots) /= firstRoot)) (the (List (Fin 7)) [0,1,2,3,4,5,6]) == Nothing
