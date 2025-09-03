// Dedicated to Shree DR.MDD
module TwoBucket

type Bucket = | One = 1 | Two = 2
type Outcome = { Moves:int; GoalBucket:Bucket; OtherBucket:int }

let private pour (x,y) (_,capY) = 
    let newY = if y + x > capY then capY else y + x
    let newX = if y + x <= capY then 0 else x - (capY - y)
    (newX, newY)

let private pourBack (x,y) (capX,_) = 
    let (resY,resX) = pour (y,x) (0,capX)
    (resX, resY)

let rec private explore path (cap1,cap2) goal forbidden current : Outcome option =
    let updatedPath = path @ [current]
    match current with
    | (x,y) when x = goal -> Some { Moves = updatedPath.Length; GoalBucket = Bucket.One; OtherBucket = y }
    | (x,y) when y = goal -> Some { Moves = updatedPath.Length; GoalBucket = Bucket.Two; OtherBucket = x }
    | (x,y) ->
        [(x,0);(0,y);(cap1,y);(x,cap2);pour (x,y) (cap1,cap2);pourBack (x,y) (cap1,cap2)]
        |> List.filter (fun state -> not (List.contains state updatedPath) && state <> forbidden)
        |> List.map (explore updatedPath (cap1,cap2) goal forbidden)
        |> List.choose id
        |> List.sortBy (fun o -> o.Moves)
        |> List.tryHead

let measure sizeA sizeB goal (start:Bucket) : Outcome =
    let initial = if start = Bucket.One then (sizeA,0) else (0,sizeB)
    let forbidden = if start = Bucket.One then (0,sizeB) else (sizeA,0)
    explore [] (sizeA,sizeB) goal forbidden initial
    |> function
    | Some result -> result
    | None -> failwith "Unsolvable"
