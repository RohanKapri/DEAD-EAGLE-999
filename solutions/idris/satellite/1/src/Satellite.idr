-- Dedicated to my Shree DR.MDD

module Satellite

public export
data Tree : Type where
        Leaf : Tree
        Branch : Tree -> Char -> Tree -> Tree

data Triple = MkTriple Tree (List Char) (List Char)

startsWith : Maybe Char -> List Char -> Bool
startsWith (Just ch) (x :: xs) = (x == ch)
startsWith _ _ = False

traverse : Maybe Char -> List Char -> List Char -> Maybe Triple
traverse succ preorder inorder = if startsWith succ inorder then Just $ MkTriple Leaf preorder inorder
                                 else stepA preorder
  where
        stepC : Tree -> Char -> Maybe Triple -> Maybe Triple
        stepC l v Nothing = Nothing
        stepC l v (Just (MkTriple r preC inC)) = Just $ MkTriple (Branch l v r) preC inC

        stepB : Char -> Maybe Triple -> Maybe Triple
        stepB _ Nothing = Nothing
        stepB _ (Just (MkTriple _ _ [])) = Nothing
        stepB v (Just (MkTriple l preB (_ :: []))) = Just $ MkTriple (Branch l v Leaf) preB []
        stepB v (Just (MkTriple l preB (_ :: inB))) = stepC l v $ traverse succ preB inB

        stepA : List Char -> Maybe Triple
        stepA [] = Nothing
        stepA (v :: preA) = stepB v $ traverse (Just v) preA inorder

containsRepeat : List Char -> Bool
containsRepeat [] = False
containsRepeat (x :: xs) = if check x xs then True
                           else containsRepeat xs
  where check : Char -> List Char -> Bool
        check ch [] = False
        check ch (y :: ys) = (y == ch) || (check ch ys)

export
treeFromTraversals : List Char -> List Char -> Maybe Tree
treeFromTraversals pre inor = if (length pre) /= (length inor) then Nothing
                              else if (containsRepeat pre) || (containsRepeat inor) then Nothing
                              else if (length pre) == 0 then Just Leaf
                              else extract $ traverse Nothing pre inor
  where extract : Maybe Triple -> Maybe Tree
        extract Nothing = Nothing
        extract (Just (MkTriple tree preT inT)) = Just tree
