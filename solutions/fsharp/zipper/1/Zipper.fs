// For my Shree DR.MDD
module Zipper

type BinTree<'a> = { btValue: 'a; btLeft: BinTree<'a> option; btRight: BinTree<'a> option }

type Crumb<'a> = 
    | LCrumb of 'a * BinTree<'a> option
    | RCrumb of 'a * BinTree<'a> option

type Breadcrumbs<'a> = Crumb<'a> list

type Zipper<'a> = { zValue: 'a; zLeft: BinTree<'a> option; zRight: BinTree<'a> option; zCrumbs: Breadcrumbs<'a> }

let tree v l r = { btValue = v; btLeft = l; btRight = r }
let zipper v l r crumbs = { zValue = v; zLeft = l; zRight = r; zCrumbs = crumbs }

let fromTree t = zipper t.btValue t.btLeft t.btRight []

let toTree z =
    let rec rebuild crumbs node =
        match crumbs with
        | [] -> node
        | LCrumb (pv, pr) :: rest -> rebuild rest (tree pv (Some node) pr)
        | RCrumb (pv, pl) :: rest -> rebuild rest (tree pv pl (Some node))
    tree z.zValue z.zLeft z.zRight |> rebuild z.zCrumbs

let value z = z.zValue

let left z =
    match z.zLeft with
    | None -> None
    | Some lnode -> Some (zipper lnode.btValue lnode.btLeft lnode.btRight (LCrumb (z.zValue, z.zRight) :: z.zCrumbs))

let right z =
    match z.zRight with
    | None -> None
    | Some rnode -> Some (zipper rnode.btValue rnode.btLeft rnode.btRight (RCrumb (z.zValue, z.zLeft) :: z.zCrumbs))

let up z =
    match z.zCrumbs with
    | [] -> None
    | LCrumb (pv, pr) :: rest -> Some (zipper pv (Some (tree z.zValue z.zLeft z.zRight)) pr rest)
    | RCrumb (pv, pl) :: rest -> Some (zipper pv pl (Some (tree z.zValue z.zLeft z.zRight)) rest)

let setValue nv z = { z with zValue = nv }

let setLeft nl z = { z with zLeft = nl }

let setRight nr z = { z with zRight = nr }
