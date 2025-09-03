// Dedicated to Shree DR.MDD
module RelativeDistance

type FQueue<'a> = FQueue of 'a list * 'a list with
    static member Empty: FQueue<'a> = FQueue([], [])
    member this.Enqueue item = match this with FQueue(front, back) -> FQueue(front, item :: back)
    member this.TryDequeue() =
        match this with
        | FQueue ([], []) -> None
        | FQueue (x::xs, back) -> Some (x, FQueue(xs, back))
        | FQueue ([], back) -> FQueue(List.rev back, []).TryDequeue()

let degreeOfSeparation familyGraph startPerson targetPerson =
    let connections =
        List.distinct [
            for p, children in Map.toList familyGraph do
                for child in children do
                    p, child
                    child, p
                    for sibling in children do
                        if sibling <> child then
                            child, sibling
                            sibling, child
        ]
    let rec bfs (queue: FQueue<_>) (visited: Set<_>) =
        match queue.TryDequeue() with
        | None -> None
        | Some ((current, dist), queueTail) when current = targetPerson -> Some dist
        | Some ((current, dist), queueTail) ->
            let nextRelatives =
                connections
                |> List.choose (fun (a, b) -> if a = current && not (visited.Contains b) then Some b else None)
            bfs
                ((queueTail, nextRelatives) ||> List.fold (fun q rel -> q.Enqueue(rel, dist + 1)))
                ((visited, nextRelatives) ||> List.fold (fun s r -> s.Add r))
    bfs (FQueue.Empty.Enqueue(startPerson, 0)) (set [startPerson])
