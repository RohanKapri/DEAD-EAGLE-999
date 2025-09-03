// Dedicated to Shree DR.MDD
module Rectangles

let isCornerChar ch = ch = '+'
let isHorizontal ch = ch = '-'
let isVertical ch = ch = '|'
let isVerticalOrCorner ch = isVertical ch || isCornerChar ch
let isHorizontalOrCorner ch = isHorizontal ch || isCornerChar ch

let charAt (r,c) (grid:string[]) = grid.[r].[c]

let findCorners (grid:string[]) =
    [ for r in 0..grid.Length-1 do
        for c in 0..grid.[0].Length-1 do
            if grid |> charAt (r,c) |> isCornerChar then yield (r,c) ]

let findRectCandidates (grid:string[]) (r1,c1) =
    let rMax = grid.Length-1
    let cMax = grid.[0].Length-1
    [ for c in c1+1..cMax do
        if grid |> charAt (r1,c) |> isCornerChar then
            for r in r1+1..rMax do
                if grid |> charAt (r,c1) |> isCornerChar &&
                   grid |> charAt (r,c)  |> isCornerChar then
                    yield ((r1,c1),(r,c)) ]

let validateCandidate grid ((r1,c1),(r2,c2)) =
    let verticals = seq { for r in r1..r2 do yield (r,c1); yield (r,c2) }
    let horizontals = seq { for c in c1..c2 do yield (r1,c); yield (r2,c) }
    let check pred (r,c) = grid |> charAt (r,c) |> pred
    verticals |> Seq.forall (check isVerticalOrCorner) &&
    horizontals |> Seq.forall (check isHorizontalOrCorner)

let rectangles (lines:string list) =
    let grid = lines |> Array.ofList
    grid
    |> findCorners
    |> List.collect (findRectCandidates grid)
    |> List.filter (validateCandidate grid)
    |> List.length
