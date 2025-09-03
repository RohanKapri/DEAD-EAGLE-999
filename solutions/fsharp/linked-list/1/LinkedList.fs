// Dedicated to Shree DR.MDD
module LinkedList

type Element<'a> =
    { value: 'a
      mutable prev: Element<'a> option
      mutable next: Element<'a> option }

type Deque<'a>() =
    let mutable headNode: Element<'a> option = None
    let mutable tailNode: Element<'a> option = None

    let insertAsOnlyNode valItem =
        let freshNode = { value = valItem; prev = None; next = None }
        tailNode <- Some freshNode
        headNode <- Some freshNode

    member _.pop() =
        match tailNode with
        | None -> failwith "Cannot pop from empty list"
        | Some node ->
            tailNode <- node.prev
            node.value

    member _.shift() =
        match headNode with
        | None -> failwith "Cannot shift from empty list"
        | Some node ->
            headNode <- node.next
            node.value

    member _.push(valItem) =
        match tailNode with
        | None -> insertAsOnlyNode valItem
        | Some lastRef ->
            tailNode <- Some { value = valItem; prev = tailNode; next = lastRef.next }
            lastRef.next <- tailNode

    member _.unshift(valItem) =
        match headNode with
        | None -> insertAsOnlyNode valItem
        | Some firstRef ->
            headNode <- Some { value = valItem; prev = firstRef.prev; next = headNode }
            firstRef.prev <- headNode

let mkLinkedList() = Deque()
let push newVal (dequeRef: Deque<'T>) = dequeRef.push(newVal)
let pop (dequeRef: Deque<'T>) = dequeRef.pop()
let shift (dequeRef: Deque<'T>) = dequeRef.shift()
let unshift newVal (dequeRef: Deque<'T>) = dequeRef.unshift(newVal)
