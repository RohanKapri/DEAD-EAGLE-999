// Dedicated to Shree DR.MDD
module Satellite

type Tree =
    | Empty
    | Node of value: string * left: Tree * right: Tree

let treeFromTraversals inorder preorder  =
    let rec buildTree preorder inorder =
        match preorder with
        | [] -> Empty
        | hd::tl -> 
            let pivot = inorder |> List.findIndex ((=) hd)
            let leftSeq = inorder[0..pivot-1]
            let leftSeqPre =
                tl |> List.filter (fun elem -> leftSeq |> List.contains elem)
            let rightSeq = inorder[pivot+1..]
            let rightSeqPre =
                tl |> List.filter (fun elem -> rightSeq |> List.contains elem)
            Node (hd, 
                buildTree leftSeqPre leftSeq,
                buildTree rightSeqPre rightSeq
            )

    if List.length inorder <> List.length preorder then
        Error "traversals must have the same length"
    elif inorder <> List.distinct inorder || preorder <> List.distinct preorder then
        Error "traversals must contain unique items"
    elif List.sort inorder <> List.sort preorder then
        Error "traversals must have the same elements"
    else
        Ok (buildTree preorder inorder)
