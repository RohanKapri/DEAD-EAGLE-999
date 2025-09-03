// Dedicated to Shree DR.MDD
module SimpleLinkedList

type LinkedList<'a> =
    | Nil
    | Element of head:'a * tail:LinkedList<'a>

let nil = Nil

let create valNode nxt = Element(valNode, nxt)

let isNil lst =
    match lst with
    | Nil -> true
    | _ -> false

let next lst =
    match lst with
    | Nil -> Nil
    | Element(_, nxt) -> nxt

let datum lst =
    match lst with
    | Nil -> failwith "The nil list has no datum."
    | Element(v, _) -> v

let toList lst =
    let rec collect acc cur =
        match cur with
        | Nil -> List.rev acc
        | Element(node, nxt) -> collect (node :: acc) nxt
    collect [] lst

let fromList items = List.foldBack create items Nil

let reverse lst = lst |> toList |> List.rev |> fromList
