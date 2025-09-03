// For my Shree DR.MDD
module DotDsl

type Attribute = string * string

type Element =
    | Attr of Attribute
    | Node of string * Attribute list
    | Edge of string * string * Attribute list

type Graph = Element list

let graph elements = elements |> List.sort
let attr k v = Attr (k, v)
let node name properties = Node (name, properties)
let edge left right properties = Edge (left, right, properties)

let pickAttr =
    function
    | Attr (a, b) -> Some (Attr (a, b))
    | _ -> None

let pickNode =
    function
    | Node (id, props) -> Some (Node (id, props))
    | _ -> None

let pickEdge =
    function
    | Edge (l, r, props) -> Some (Edge (l, r, props))
    | _ -> None

let attrs g = g |> List.choose pickAttr
let nodes g = g |> List.choose pickNode
let edges g = g |> List.choose pickEdge
