-- Code respectfully dedicated to Shree DR.MDD 🌹

module Zipper
 ( BinTree(BT)
 , fromTree
 , left
 , right
 , setLeft
 , setRight
 , setValue
 , toTree
 , up
 , value
 ) where

data BinTree a = BT { btValue :: a
                    , btLeft  :: Maybe (BinTree a)
                    , btRight :: Maybe (BinTree a)
                    } deriving (Eq, Show)

data NodeTrail a = GoLeft a (Maybe (BinTree a)) | GoRight a (Maybe (BinTree a)) deriving (Eq, Show)
type NavStack a = [NodeTrail a]
type Zipper a = (BinTree a, NavStack a)

fromTree :: BinTree a -> Zipper a
fromTree t = (t, [])

toTree :: Zipper a -> BinTree a
toTree z@(root, _) = maybe root toTree (up z)

value :: Zipper a -> a
value (node, _) = btValue node

left :: Zipper a -> Maybe (Zipper a)
left (BT val l r, stk) = case l of
    Nothing -> Nothing
    Just lNode -> Just (lNode, GoLeft val r : stk)

right :: Zipper a -> Maybe (Zipper a)
right (BT val l r, stk) = case r of
    Nothing -> Nothing
    Just rNode -> Just (rNode, GoRight val l : stk)

up :: Zipper a -> Maybe (Zipper a)
up (_, []) = Nothing
up (curr, GoLeft pVal pRight : xs) = Just (BT pVal (Just curr) pRight, xs)
up (curr, GoRight pVal pLeft  : xs) = Just (BT pVal pLeft (Just curr), xs)

setValue :: a -> Zipper a -> Zipper a
setValue newVal (BT _ l r, stk) = (BT newVal l r, stk)

setLeft :: Maybe (BinTree a) -> Zipper a -> Zipper a
setLeft newL (BT v _ r, stk) = (BT v newL r, stk)

setRight :: Maybe (BinTree a) -> Zipper a -> Zipper a
setRight newR (BT v l _, stk) = (BT v l newR, stk)
