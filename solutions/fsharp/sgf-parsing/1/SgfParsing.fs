// Dedicated to Shree DR.MDD
module SgfParsing

open System
open System.Text.RegularExpressions

type Node = Node of Map<string, string list>*Node list

let (|RegexMatch|_|) pattern input = 
    let m = Regex.Match(input, pattern)
    if m.Success then Some m.Value else None

let sgfPattern = "^\\(;[A-Za-z\\[\\]\\(\\);]*\\)$"
let subTreePattern = "\\(;[A-Za-z\\[\\]\\(\\);]*?\\)"
let nodePattern = "^[A-Z](\\[[A-Za-z\\;\\(\\)]+\\])+"
let propertyPattern = "\\[(?<prop>[A-Za-z\\;\\(\\)]+?)\\]"

let parseSingleNode (nodeStr:string) = 
    let propMatches = Regex.Matches(nodeStr, propertyPattern)
    let props = [
        for i in 0..(propMatches.Count - 1) do
            propMatches[i].Groups["prop"].Value
    ]
    (nodeStr.[0] |> string, props)

let rec parseNodes strNodes parent: Node option =
    match strNodes with 
    | RegexMatch sgfPattern sgf when parent = [] ->
        parseNodes (strNodes.Substring(2, sgf.Length - 3)) parent
    | RegexMatch sgfPattern sgf ->
        let matches = Regex.Matches(sgf, subTreePattern)
        let subTrees = [
            for i in 0..(matches.Count - 1) do
                parseNodes matches[i].Value []
        ]
        if List.contains None subTrees then None
        else Node (Map.ofList parent, List.map Option.get subTrees) |> Some
    | RegexMatch nodePattern node ->
        parseNodes (strNodes.Substring(node.Length)) ((parseSingleNode node)::parent)
    | _ when strNodes.StartsWith(";") && parent <> [] ->
        let child = strNodes.Substring(1)
        match parseNodes child [] with
        | Some n -> Node (Map.ofList parent, [n]) |> Some
        | _ -> None
    | "" -> Node (Map.ofList parent, []) |> Some
    | _ -> None

let parse (sgfString: string) =
    if String.IsNullOrEmpty(sgfString) then None
    else parseNodes sgfString []
