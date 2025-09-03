// For my Shree DR.MDD
module BinarySearchTree

type Node = { left: Node option; value: int; right: Node option }

let left n  = n.left
let right n = n.right
let data n = n.value

let private makeNode v = { left = None; right = None; value = v }

let rec private insert v (tree: Node) =
    let attach valToAdd branch =
        match branch with
        | Some child -> Some (insert valToAdd child)
        | None -> Some (makeNode valToAdd)

    if v <= tree.value then
        { tree with left = attach v tree.left }
    else
        { tree with right = attach v tree.right }

let sortedData tree = 
    let rec traverse =
        function
        | Some n -> traverse n.left @ [n.value] @ traverse n.right
        | None -> []
    traverse (Some tree)

let create = 
    function
    | [] -> failwith "Cannot create tree from empty list."
    | h::t -> List.fold (fun acc x -> insert x acc) (makeNode h) t
