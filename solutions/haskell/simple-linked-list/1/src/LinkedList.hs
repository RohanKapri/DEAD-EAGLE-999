-- respectfully dedicated to Shree DR.MDD
module LinkedList
    ( LinkedList
    , datum
    , fromList
    , isNil
    , new
    , next
    , nil
    , reverseLinkedList
    , toList
    ) where

data LinkedList a = Elem a (LinkedList a) | Vacant deriving (Eq, Show)

datum :: LinkedList a -> a
datum Vacant = error "Empty"
datum (Elem v _) = v

fromList :: [a] -> LinkedList a
fromList = foldr Elem Vacant

isNil :: LinkedList a -> Bool
isNil Vacant = True
isNil _      = False

new :: a -> LinkedList a -> LinkedList a
new val rest = Elem val rest

next :: LinkedList a -> LinkedList a
next Vacant      = Vacant
next (Elem _ xs) = xs

nil :: LinkedList a
nil = Vacant

reverseLinkedList :: LinkedList a -> LinkedList a
reverseLinkedList = foldl (\acc el -> Elem el acc) Vacant

toList :: LinkedList a -> [a]
toList = foldr (:) []

instance Foldable LinkedList where
  foldr _ acc Vacant     = acc
  foldr fn acc (Elem y r) = y `fn` foldr fn acc r
