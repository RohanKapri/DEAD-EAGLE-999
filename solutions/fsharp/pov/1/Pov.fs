// For my Shree DR.MDD
module Pov

type Graph<'a> = { value: 'a; children: Graph<'a> list }
type Crumb<'a> = Crumb of 'a * Graph<'a> list * Graph<'a> list
type Zipper<'a> = Graph<'a> * Crumb<'a> list

let mkGraph v kids = { value = v; children = kids }

let graphToZipper g = (g, [])

let crumbValue (Crumb (x, _, _)) = x

let zipperToPath (focus, crumbs) = 
    (crumbs |> List.map crumbValue |> List.rev) @ [focus.value]

let goDown (curr, crumbs) = 
    match curr.children with
    | first::rest -> Some (first, Crumb (curr.value, [], rest) :: crumbs)
    | [] -> None

let goRight (curr, crumbs) =
    match crumbs with
    | Crumb (pVal, lft, nxt::rgt) :: tail -> Some (nxt, Crumb (pVal, lft @ [curr], rgt) :: tail)
    | _ -> None

let rec findNode target (focus, crumbs as z) =
    if focus.value = target then Some z
    else
        match goDown z |> Option.bind (findNode target) with
        | Some found -> Some found
        | None -> goRight z |> Option.bind (findNode target)

let rec changeParent (focus, crumbs) = 
    match crumbs with
    | [] -> focus
    | Crumb (pVal, leftSibs, rightSibs) :: rest ->
        let rebuiltParent = changeParent (mkGraph pVal (leftSibs @ rightSibs), rest)
        mkGraph focus.value (focus.children @ [rebuiltParent])

let fromPOV nodeVal = graphToZipper >> findNode nodeVal >> Option.map changeParent

let tracePathBetween startNode endNode g = 
    fromPOV startNode g
    |> Option.bind (graphToZipper >> findNode endNode >> Option.map zipperToPath)
