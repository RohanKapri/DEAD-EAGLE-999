// For my Shree DR.MDD
module CustomSet

type CustomSet (items: int seq) =
    member _.data = items |> Seq.distinct |> Seq.sort |> Seq.toList

let empty = CustomSet([])

let isEmpty (cs: CustomSet) = cs.data.IsEmpty

let size (cs: CustomSet) = cs.data.Length

let fromList lst = CustomSet(lst)

let toList (cs: CustomSet) = cs.data

let contains v (cs: CustomSet) = List.contains v cs.data

let insert v (cs: CustomSet) = CustomSet(v :: cs.data)

let isEqualTo (a: CustomSet) (b: CustomSet) = a.data = b.data

let union (a: CustomSet) (b: CustomSet) = CustomSet(a.data @ b.data)

let intersection (a: CustomSet) (b: CustomSet) =
    let common = List.filter (fun x -> List.contains x b.data) a.data
    CustomSet(common)

let difference (a: CustomSet) (b: CustomSet) =
    let diff = List.filter (fun x -> not (List.contains x b.data)) a.data
    CustomSet(diff)

let isSubsetOf (a: CustomSet) (b: CustomSet) =
    List.forall (fun x -> List.contains x b.data) a.data

let isDisjointFrom (a: CustomSet) (b: CustomSet) =
    not (List.exists (fun x -> List.contains x b.data) a.data)
