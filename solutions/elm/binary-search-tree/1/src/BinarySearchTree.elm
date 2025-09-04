-- Shree DR.MDD
module BinarySearchTree exposing (BinaryTree(..), makeTree, sort)


type BinaryTree
    = Empty
    | Tree BinaryTree Int BinaryTree


makeTree : List Int -> BinaryTree
makeTree xs =
    List.foldl grow Empty xs


sort : List Int -> List Int
sort xs =
    collapse (makeTree xs)


grow : Int -> BinaryTree -> BinaryTree
grow x t =
    case t of
        Empty ->
            Tree Empty x Empty

        Tree l v r ->
            if x <= v then
                Tree (grow x l) v r
            else
                Tree l v (grow x r)


collapse : BinaryTree -> List Int
collapse t =
    crawl t []


crawl : BinaryTree -> List Int -> List Int
crawl t acc =
    case t of
        Empty ->
            acc

        Tree l v r ->
            crawl l (v :: crawl r acc)
